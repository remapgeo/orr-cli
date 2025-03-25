# DONE retirando reflorestamento das colunas
from enum import Enum
import sqlalchemy.types as types
import numpy as np


class UserType(str, Enum):
    MASTER = 'Master'
    TEC = 'Tecnico'
    INVALID = 'Invalid'


MHIDRO = {
    'objectid': types.BigInteger,
    'cd_micro_rh': types.BigInteger,
    'nm_micro_rh': types.VARCHAR,
    'cd_meso_rh': types.BigInteger,
    'nm_meso_rh': types.VARCHAR,
    'cd_macro_rh': types.SMALLINT,
    'nm_macro_rh': types.VARCHAR,
    'area': types.REAL,
}


MREGIAO = {
    'objectid': types.BigInteger,
    'regiao': types.VARCHAR,
    'cd_geouf': types.BigInteger,
    'cd_country': types.SMALLINT,
    'uf': types.VARCHAR,
    'estado': types.VARCHAR,
    'cd_geocmu': types.BigInteger,
    'municipio': types.VARCHAR,
    'bioma': types.VARCHAR,
    'amaz_legal': types.BOOLEAN,
    'matopiba': types.BOOLEAN,
    'amacro': types.BOOLEAN,
    'pol_ha': types.REAL,
    'mun_ha': types.REAL,
    'pct_areapo': types.REAL,
    'cd_bioma': types.SMALLINT,
    'cd_regiao': types.SMALLINT,
}


def creatColuns(name):
    __options = {
        'MetComb': {
            'cat01': ['mrs00'],
            'cat02': ['mrs00'],
            'cat03': ['mrs00'],
        },
        'MetPrinc': {
            'cat01': 'mrs00',
            'cat02': 'mrs00',
            'cat03': 'mrs00',
        },
        'Monitora': {
            'cat01': 'mon00',
            'cat02': 'mon00',
            'cat03': 'mon00',
        },
        'Motivacao': {
            'cat01': 'mot00',
            'cat02': 'mot00',
            'cat03': 'mot00',
        },
        'Privacidad': {
            'cat01': 'pri04',
            'cat02': 'pri04',
            'cat03': 'pri04',
        },
        'Projeto': {
            'cat01': 'pro00',
            'cat02': 'pro00',
            'cat03': 'pro00',
        },
        'ProjAtivo': {
            'cat01': 'pja00',
            'cat02': 'pja00',
            'cat03': 'pja00',
        },
        'TipoArea': {
            'cat01': 'tip00',
            'cat02': 'tip00',
            'cat03': 'tip00',
        },
        #'TipoReflo': {
         #   'cat01': 'trf00',
         #   'cat02': 'trf00',
          #  'cat03': 'trf00',
        #},
        'UsoAnt': {
            'cat01': 'usa00',
            'cat02': 'usa00',
            'cat03': 'usa00',
        },
        'AnoPrevist': None,
        'ProtMonit': None,
        'FreqMonit': None,
        'AnoPrevTe': None,
        'InstGest': None,
        #'EspReflo': None,
        'AreaHa': None,
        'IDNum':None,
        'Origem':None,
        'IDPacto':None,
    }

    def inner(category):
        if __options[name] is None:
            return None
        return __options[name][category]

    return inner

COLUMNSREPLACE = {  
    'idnum':'id',
'idpacto':'idpacto',
 'anoprevist': 'ano_prev',
 'anoprevte': 'ano_prev_t',
 'areaha': 'area_decl',
 'categoria':'categoria',
 'dataconcl':'dat_concl',
 'datainici':'dat_inicio',
 'fonte':'fonte',
 'freqmonit': 'freq_monit',
 'instexecu':'inst_exec',
 'instfinan':'inst_finan' ,
 'instgest': 'inst_gest',
 'link':'link',
 'metcomb':'met_comb',
 'metprinc':'met_princ',
 'monitora':'monitorada',
 'motivacao':'motivacao',
 'nmprojeto':'nm_projeto',
 'privacidad':'privac_area',
 'projativo':'proj_ativo',
 'projeto':'projeto',
 'protmonit': 'prot_monit',
 'tipoarea':'tipo_area',
 'usoant':'uso_ant',
 'origem':'origem'
}

DBTOORR = {'categoria': 'Categoria',
 'dat_concl': 'DataConcl',
 'dat_inicio': 'DataInici',
 'origem':'Origem',
 'fonte': 'Fonte',
 'inst_exec': 'InstExecu',
 'ano_prev': 'AnoPrevist',
 'ano_prev_t': 'AnoPrevTe',
 'area_decl': 'AreaHa',
 'freq_monit': 'FreqMonit',
 'id': 'IDNum',
 'idpacto': 'IDPacto',
 'inst_finan': 'InstFinan',
 'inst_gest': 'InstGest',
 'link': 'Link',
 'met_comb': 'MetComb',
 'met_princ': 'MetPrinc',
 'monitorada': 'Monitora',
 'motivacao': 'Motivacao',
 'nm_projeto': 'NmProjeto',
 'privac_area': 'Privacidad',
 'proj_ativo': 'ProjAtivo',
 'projeto': 'Projeto',
 'prot_monit': 'ProtMonit',
 'tipo_area': 'TipoArea',
 'uso_ant': 'UsoAnt'}

def getValidColumns(template):

    match template:
        case 'ma':
            obrigatorio = [
                'Categoria',
                'DataConcl',
                'DataInici',
                'Fonte',
                'InstExecu',
                'geometry',
            ]
            opcional = [
                
                'AnoPrevist',
                'AnoPrevTe',
                'AreaHa',
                #'EspReflo',
                'FreqMonit',
                'IDNum',
                'IDPacto',
                'InstFinan',
                'InstGest',
                'Link',
                'MetComb',
                'MetPrinc',
                'Monitora',
                'Motivacao',
                'NmProjeto',
                'Origem',
                'Privacidad',
                'ProjAtivo',
                'Projeto',
                'ProtMonit',
                'TipoArea',
                #'TipoReflo',
                'UsoAnt',
            ]
        case _:
            obrigatorio = [
                'Categoria',
                'DataConcl',
                'DataInici',
                'Fonte',
                'InstExecu',
                'geometry',
            ]
            opcional = [
                'AreaHa',
                #'EspReflo',
                'IDNum',
                'InstFinan',
                'InstGest',
                'Link',
                'MetComb',
                'MetPrinc',
                'Monitora',
                'Motivacao',
                'NmProjeto',
                'Privacidad',
                'ProjAtivo',
                'Projeto',
                'TipoArea',
                #'TipoReflo',
                
            ]
    return obrigatorio, opcional