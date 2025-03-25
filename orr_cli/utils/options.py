import pandas as pd
from orr_cli.utils.text import normalize_remove
from orr_cli.db import engine

def getReplaceCol(col_db, sql_suffix):
    if sql_suffix:
        sql_suffix = f"_{sql_suffix}"
    else:
        sql_suffix = ''

    _options = pd.read_sql(f"SELECT pt, code_key, text_replace FROM options.{col_db}{sql_suffix};", engine)
    _replace = {}
    for i, row in _options.iterrows():
        _replace[normalize_remove(row['pt'])] = row['code_key']
        _replace[row['code_key']] = row['code_key']
        if not row['text_replace'] is None:
            for r in row['text_replace']:
                _replace[normalize_remove(r)] = row['code_key']
                
    return _replace

def new_options_replace(col_db, sql_suffix, null=None, replace_error=True):
    _replace = getReplaceCol(col_db, sql_suffix)
    def inner(s):
        if type(s) in (int, float):
            return null
        if s is None:
            return null
        if replace_error is False:
            _erro = null
        else:
            _erro = 'ERROR'
        
        if ',' in s or (col_db == 'met_comb' or col_db == 'estra_rest'):
            array = []
            for t in s.split(','):
                if t is None:
                    array.append(null)
                else:
                    _elemeto = _replace.get(t,_erro)
                    if not _elemeto is None:
                        array.append(_replace.get(normalize_remove(t),_erro))
            return list(set(array))
        return _replace.get(normalize_remove(s),_erro)
    return inner