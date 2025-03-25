import pandas as pd

from orr_cli.logger import logger


def text(t, _type):
    
         
    if t == 'None':
        return f'NULL::{_type}'
    if t is None:
        return f'NULL::{_type}'
    if _type in ['int','double precision']:
        if isinstance(t,float):
            if pd.isna(t):
                return f'NULL::{_type}'
        if _type == 'int':
            try:
                if '.' in t:
                    return f'{int(float())}::{_type}'
                
                
                return f'{int(t)}::{_type}'
            except:
                return f'NULL::{_type}'
        return f'{t}::{_type}'
    text = str(t).replace("'","''")
    return f"'{text}'::{_type}" 

def to_array(t):
    if t == 'None':
        return []
    if t is None:
        return []
    if t.startswith('['):
        return eval(t)
    if not isinstance(t,list):
        if ',' in t:
            return t.split(',')
        else:
            return [t]
    return t


def get_query(row,schema, suffix): 
    
    try:
        match suffix:
            case 'ma':
                
                    
                return f""" select ob_add_feature_ma(
                    '{schema}'::text,
                    'SRID=4674;{row['geometry'].wkt}'::text, -- geometry
                    {text(row['polyid'],'varchar')}, -- polyid
                    {text(row['id'],'int')}, --i
                    {text(row['categoria'],'varchar')}, --categoria
                    {text(row['projeto'],'varchar')}, --projeto
                    {text(row['nm_projeto'],'varchar')}, --nm_projeto
                    {text(row['origem'],'varchar')}, --origem
                    {text(row['idpacto'],'varchar')}, --idpacto
                    {text(row['inst_exec'],'varchar')}, --inst_exec
                    {text(row['inst_gest'],'varchar')}, --inst_gest
                    {text(row['inst_finan'],'varchar')}, --inst_finan
                    {text(row['met_princ'],'varchar')}, --met_princ
                    {text(row['uso_ant'],'varchar')}, --uso_ant
                    {text(row['motivacao'],'varchar')}, --motivacao
                    {text(row['tipo_area'],'varchar')}, --tipo_area
                    {text(row['dat_inicio'],'text')}, --dat_inicio
                    {text(row['proj_ativo'],'varchar')}, --proj_ativo
                    {text(row['dat_concl'],'text')}, --dat_concl
                    {text(row['area_decl'],'double precision')}, --area_decl
                    {text(row['monitorada'],'varchar')}, --monitorada
                    {text(row['prot_monit'],'varchar')}, --prot_monit
                    {text(row['freq_monit'],'varchar')},-- freq_monit
                    {text(row['ano_prev'],'varchar')},-- ano_prev
                    {text(row['ano_prev_t'],'varchar')},-- ano_prev_t
                    {text(row['fonte'],'varchar')}, --fonte
                    {text(row['link'],'varchar')}, --link
                    {text(row['privac_area'],'varchar')}, --privac_are
                    array{to_array(row['met_comb'])}::text[]
                );"""
                
            case _:
               
                return f"""select ob_add_feature(
                    '{schema}'::text,
                    'SRID=4674;{row['geometry'].wkt}'::text, -- geometry
                    {text(row['polyid'],'varchar')}, -- polyid
                    {text(row['id'],'int')}, --id
                    {text(row['categoria'],'varchar')}, --categoria
                    {text(row['projeto'],'varchar')}, --projeto
                    {text(row['nm_projeto'],'varchar')}, --nm_projeto
                    {text(row['inst_exec'],'varchar')}, --inst_exec
                    {text(row['inst_gest'],'varchar')}, --inst_gest
                    {text(row['inst_finan'],'varchar')}, --inst_finan
                    {text(row['met_princ'],'varchar')}, --met_princ
                    {text(row['motivacao'],'varchar')}, --motivacao
                    {text(row['tipo_area'],'varchar')}, --tipo_area
                    {text(row['dat_inicio'],'text')}, --dat_inicio
                    {text(row['proj_ativo'],'varchar')}, --proj_ativo
                    {text(row['dat_concl'],'text')}, --dat_concl
                    {text(row['area_decl'],'double precision')}, --area_decl
                    {text(row['monitorada'],'varchar')}, --monitorada
                    {text(row['fonte'],'varchar')}, --fonte
                    {text(row['link'],'varchar')}, --link
                    {text(row['privac_area'],'varchar')}, --privac_are
                    array{to_array(row['met_comb'])}::text[]
                );"""
    except KeyError:
        logger.exception('Colunal ausente')
        raise Exception('Colunal ausente')
    except Exception as ex:
        logger.exception('Error')
        logger.debug(ex)
        raise Exception('Error inserting')