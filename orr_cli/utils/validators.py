import os
import sys
from orr_cli.functions import check_caracter, is_url
from orr_cli.utils.date import apply_date

from pathlib import Path
import hashlib
from pprint import pprint


import geopandas as gpd
from orr_cli.model import COLUMNSREPLACE, DBTOORR, creatColuns, getValidColumns
from orr_cli.utils.auth import metadataUser
from orr_cli.utils.callbak import isTec
from orr_cli.utils.geometrValid import convert_3D_2D
from orr_cli.utils.insert import get_query
from orr_cli.utils.options import new_options_replace
import psycopg2
from rich.console import Console
from rich.progress import track
from rich.prompt import Confirm, Prompt
from rich.table import Table

from tqdm import tqdm
from psycopg2 import sql, errors
from typer import Argument, Typer
from orr_cli.logger import logger
from orr_cli.config import templets
from orr_cli.db import db_params

from orr_cli.i18n import Translator

from orr_cli.utils.exceptions import OrrDictValidationError, OrrValidationError


# instantiate a new Translator class with the path to the data
tl = Translator()
crs_ibge = "+proj=aea +lat_0=-12 +lon_0=-54 +lat_1=-2 +lat_2=-22 +x_0=5000000 +y_0=10000000 +ellps=GRS80 +units=m +no_defs"

CRS = crs_ibge

console = Console()
app = Typer(help=tl.translate("file_help_menu"), callback=isTec)

text_cat = tl.translate("text_cat")


def validate_file(gdf, hash, username = None):
    
    _errors = {
        'error': False,
        'columns': {
            'ausente': [],
            'excedente': [],
            'geometry': [],
        },
        'rows': []
    }
    error_rows = []

    # Check columns
    if username is None:
        user = metadataUser()
    else:
        user = metadataUser(username)
        
    user_suffix = user['suffix'] if user is not None else ''
    columns = gdf.columns
    
    obrigatorio, opcional = getValidColumns(user_suffix)
    
    erros_obrigatoria_ausente = list(
        set(obrigatorio) - set([i for i in columns if i in obrigatorio]))

    if len(erros_obrigatoria_ausente) > 0:
        _errors['error'] = True
        _errors['columns']['ausente'] = erros_obrigatoria_ausente

    erros_obrigatoria_excendente = [
        i for i in columns if not i in [*obrigatorio, *opcional]]
    logger.debug([*obrigatorio, *opcional])
    if len(erros_obrigatoria_excendente) > 0:
        _errors['error'] = True
        _errors['columns']['excedente'] = erros_obrigatoria_excendente

    gdf.columns = [str(i).lower() for i in gdf.columns]
    gdf = gdf.rename(columns=COLUMNSREPLACE)

    ops_errors = {
        'categoria': {'null': 'AUSENTE', 'replace_error': True},
        # 'estra_rest':None,
        'met_comb': {'null': None, 'replace_error': True},
        'met_princ': {'null': 'AUSENTE', 'replace_error': True},
        'monitorada': {'null': None, 'replace_error': True},
        'motivacao': {'null': None, 'replace_error': True},
        'privac_area': {'null': None, 'replace_error': True},
        'proj_ativo': {'null': None, 'replace_error': True},
        'projeto': {'null': None, 'replace_error': True},
        'tipo_area': {'null': None, 'replace_error': True},
        'uso_ant': {'null': None, 'replace_error': True},
        'dat_concl': {'null': None, 'replace_error': True},
        'dat_inicio': {'null': None, 'replace_error': True},

    }

    # TODO: Erros de escrita

    for col in [i for i in DBTOORR if i not in ['link']]:
        if col in gdf.columns:
            for index, value in enumerate(gdf[col].apply(check_caracter),1):
                if value:
                    error_rows.append(
                            'Error at line Character {}: The provided value in the column {} is invalid'.format(index, DBTOORR[col])
                        )
    for index, value in enumerate(gdf['link'].apply(is_url),1):
        if not value:
            error_rows.append(
                            'Error Link at line {}: The provided value in the column {} is invalid'.format(index, DBTOORR['link'])
                        )

    for ops_col in ops_errors:
        if ops_col in gdf.columns:
            try:
                if ops_col in ['dat_concl', 'dat_inicio']:
                    fapp_date = apply_date(True)
                    gdf[ops_col] = gdf[ops_col].apply(fapp_date)
                else:
                    f_replace = new_options_replace(
                        ops_col, user_suffix, **ops_errors[ops_col])
                    gdf[ops_col] = gdf[ops_col].apply(f_replace)
            except Exception as e:
                raise OrrValidationError(e.__str__())

            for index, val in enumerate(gdf[ops_col], 1):
                if val is not None:
                    if 'ERROR' in val:
                        error_rows.append(
                            'Error at line {}: The provided value in the column {} is invalid'.format(index, DBTOORR[ops_col])
                        )
                    if 'AUSENTE' in val:
                        error_rows.append(
                            'Error at line {}: The column {} cannot be empty. Please fill the column with a valid option'.format(index, DBTOORR[ops_col])
                        )


    if len(error_rows) > 0:
        _errors['error'] = True
        _errors['rows'] = error_rows

    if _errors['error']:
        raise OrrDictValidationError(_errors)


    for i in [COLUMNSREPLACE[i.lower()] for i in opcional]:
        if not i in gdf.columns:
            new_op = creatColuns(DBTOORR[i])
            gdf[i] = gdf['categoria'].apply(new_op)

    crs = gdf.crs
    if not crs == 'EPSG:4674':
        gdf = gdf.to_crs(4674)

    if any(gdf['geometry'].has_z):
        gdf.geometry = convert_3D_2D(gdf.geometry)

    gdf.geometry = gdf.geometry.make_valid()

    rows = []

    for i, row in gdf.iterrows():
        row['polyid'] = f'{hash}-{i}'
        if row['geometry'].geom_type == 'Polygon':
            rows.append(row.to_dict())
        elif row['geometry'].geom_type == 'MultiPolygon':
            for geom in row['geometry'].geoms:
                row_copy = row.copy()
                row_copy['geometry'] = geom
                rows.append(row_copy.to_dict())
        elif row['geometry'].geom_type == 'GeometryCollection':
            for geom1 in gpd.GeoSeries(row['geometry'].geoms).make_valid():
                if geom1.geom_type == 'Polygon':
                    row_copy = row.copy()
                    row_copy['geometry'] = geom1
                    rows.append(row_copy.to_dict())
                elif geom1.geom_type == 'MultiPolygon':
                    for geom2 in geom1.geoms:
                        row_copy = row.copy()
                        row_copy['geometry'] = geom2
                        rows.append(row_copy.to_dict())

    valid_gdf = gpd.GeoDataFrame(rows, crs=4674)

    valid_gdf['geometry'] = valid_gdf['geometry'].make_valid()

    rows = []

    for i, row in valid_gdf.iterrows():
        row['polyid'] = f'{row["polyid"]}-{i}'
        if row['geometry'].geom_type == 'Polygon':
            rows.append(row.to_dict())
        elif row['geometry'].geom_type == 'MultiPolygon':
            for geom in row['geometry'].geoms:
                row_copy = row.copy()
                row_copy['geometry'] = geom
                rows.append(row_copy.to_dict())
        elif row['geometry'].geom_type == 'GeometryCollection':
            for geom1 in gpd.GeoSeries(row['geometry'].geoms).make_valid():
                if geom1.geom_type == 'Polygon':
                    row_copy = row.copy()
                    row_copy['geometry'] = geom1
                    rows.append(row_copy.to_dict())
                elif geom1.geom_type == 'MultiPolygon':
                    for geom2 in geom1.geoms:
                        row_copy = row.copy()
                        row_copy['geometry'] = geom2
                        rows.append(row_copy.to_dict())

    valid_gdf = gpd.GeoDataFrame(rows, crs=4674)

    valid_gdf['geometry'] = valid_gdf['geometry'].make_valid()


    if all(valid_gdf['geometry'].is_valid) is False:
        logger.error('Tem geometria invalida')

    for gtype in valid_gdf['geometry'].geom_type:
        if not gtype == 'Polygon':
            raise OrrValidationError('Geometry error')

    def met_comb_str(x):
        if x is None:
            return None
        return ','.join(x)

    for col in valid_gdf.columns:
        if col == 'met_comb':
            valid_gdf[col] = valid_gdf[col].apply(met_comb_str).astype(str)

    valid_gdf = valid_gdf[(valid_gdf.to_crs(
        crs_ibge).geometry.area/10_000).apply(lambda x: True if x > 0.009 else False)].copy()
    
    return valid_gdf
