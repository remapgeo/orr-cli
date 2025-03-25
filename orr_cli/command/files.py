import hashlib
import sys
from pathlib import Path

import geopandas as gpd
import psycopg2
from psycopg2 import errors
from rich.console import Console
from tqdm import tqdm
from typer import Argument, Typer

from orr_cli.db import db_params
from orr_cli.i18n import Translator
from orr_cli.logger import logger
from orr_cli.utils.auth import metadataUser
from orr_cli.utils.callbak import isTec
from orr_cli.utils.insert import get_query
from orr_cli.utils.validators import validate_file

# instantiate a new Translator class with the path to the data
tl = Translator()            
crs_ibge = "+proj=aea +lat_0=-12 +lon_0=-54 +lat_1=-2 +lat_2=-22 +x_0=5000000 +y_0=10000000 +ellps=GRS80 +units=m +no_defs"

CRS = crs_ibge

console = Console()
app = Typer(help=tl.translate("file_help_menu"), callback=isTec)

text_cat = tl.translate("text_cat")


def calcular_hash_caminho(caminho):
    # Calcula o hash MD5 do caminho do arquivo
    hash_obj = hashlib.sha3_256()
    hash_obj.update(caminho.encode('utf-8'))
    hash_str = hash_obj.hexdigest()
    return hash_str[:8]









@app.command()
def check(
    file: str = Argument(..., help="File to load"),
):
    _file = Path(file)
    _extensions = ['.shp', '.gpkg']
    _errors = {
        'error':False,
        'columns':{
            'ausente':[],
            'excedente':[],
            'geometry':[],
        },
        'rows':[]
    }
    error_rows = []
    if not _file.is_file():
        console.print("File does not exist")
        sys.exit(1)
    if _file.suffix not in _extensions:
        console.print("Please ensure the uploaded file is in a valid format. We only accept Shapefile (.shp) or GeoPackage (.gpkg) formats.")
        sys.exit(1)
    try:
        gdf = gpd.read_file(file)
    except Exception:
        logger.exception('Error reading file')
        sys.exit(1)
    
    valid_gdf = validate_file(gdf, calcular_hash_caminho(file))
   
    valid_gdf = valid_gdf[(valid_gdf.to_crs(crs_ibge).geometry.area/10_000).apply(lambda x: True if x > 0.009 else False)].copy()

    valid_file = str(_file.name).split('.')[0] + '_valid.gpkg'
    
    valid_gdf.to_file(valid_file)
    console.print(f'Success file saved in {valid_file}')
    
    
# TODO: ESCREVER HELPING
@app.command()
def push(
    file: str = Argument(..., help=""),
):    
    console.print('Loading file')
    _file = Path(file)
    _extensions = ['.gpkg']
    
    
    if not _file.is_file():
        console.print("File does not exist")
        sys.exit(1)
    if _file.suffix not in _extensions:
        console.print("Please ensure the uploaded file is in a valid format. We only accept GeoPackage (.gpkg) formats.")
        sys.exit(1)
    
    try:
        gdf = gpd.read_file(file)
    except Exception:
        logger.exception('Error reading file')
        sys.exit(1)
    
    geo_file = file.split('/')[-1]
    logger.info(f'Uploading GeoPackage file:{geo_file}')
    # Check columns
    user = metadataUser()
    schema = user['name'].replace('_user','')
    suffix = user['suffix']
    if suffix is None:
        suffix = ''
    
    total = len(gdf)   
    try:
        with psycopg2.connect(**db_params) as conn:
            with conn.cursor() as cur:
                for i, row in tqdm(gdf.iterrows(), total=total):
                    query = get_query(row,schema,suffix)
                    last_query = query 
                    try:
                        cur.execute(query)
                    except errors.RaiseException as e:
                        if 'Area may be repeated' in str(e):
                            logger.warning(f'Line {i+1} repeated') 
                        elif 'polygon area cannot be less than 0.01' in str(e):
                            logger.warning(f'Line {i+1} polygon area cannot be less than 0.01')
                        else:
                            logger.info(gdf.columns)
                            logger.info(last_query)
                            logger.exception('error')
                    except Exception as e:
                        logger.debug(gdf.columns)
                        logger.error(last_query)
                        logger.error(f'error id {i} {e}')
                    conn.commit()
                        
    except Exception:
        logger.exception(gdf.columns)
        
    console.print('Save all db')
