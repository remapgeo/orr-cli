from datetime import datetime
import pandas as pd


def isYear(x):
    if x > 1900 and x < 3000:
        return True
    return False

def listd2date(ldate, return_error=None):
    try:
        ldate = [int(x) for x in ldate]
    except:
        return return_error
    if len(ldate) == 1:
        if isYear(ldate[0]):
            return f'{ldate[0]}'
        return return_error
    
    if len(ldate) == 2:
        if isYear(ldate[0]):
            try:
                d = datetime(ldate[0], ldate[1], 1)
                return f'{ldate[0]}-{ldate[1]:02}'
            except:
                return return_error
        if isYear(ldate[1]):
            try:
                d = datetime(ldate[1], ldate[0], 1)
                return f'{ldate[1]}-{ldate[0]:02}'
            except Exception as e:
                return return_error
            
    if len(ldate) == 3:
        if isYear(ldate[0]):
            try:
                d = datetime(ldate[0], ldate[1], ldate[2])
                return f'{ldate[0]}-{ldate[1]:02}-{ldate[2]:02}'
            except:
                return None
        if isYear(ldate[2]):
            try:
                d = datetime(ldate[2], ldate[1], ldate[0])
                return f'{ldate[2]}-{ldate[1]:02}-{ldate[0]:02}'
            except:
                return return_error
 
def apply_date(return_error=False):           
    def datavalid(date):
        r = None
        if return_error:
            r = 'ERROR'
        if date is None or date == 0 or date == '0' or date == '0.0':
            return None
        if isinstance(date, str):
            if '-' in date:
                return listd2date(date.split('-'), r)
            if '/' in date:
                return listd2date(date.split('/'), r)
            try:
                if isYear(int(date)):
                    return f'{int(date)}'
            except:
                ...
            try:
                if isYear(int(float(date))):
                    return f'{int(float(date))}'
            except:
                ...
            return r
        if isinstance(date, int):
            if date == 0:
                return None
            if isYear(date):
                return f'{date}'
        try:
            date = int(date)
            if date == 0:
                return None
            if isYear(date):
                return f'{date}'
        except:
            return r
        return None
    return datavalid



def invert_mes_dia(date):
    if '-' in date:
        d = date.split('-')
        return f'{d[1]}-{d[0]}-{d[2]}'
    if '/' in date:
        d = date.split('/')
        return f'{d[1]}/{d[0]}/{d[2]}'
    
    
def convert_to_numeric_format(date_str):
    # Mapeamento de meses em português para inglês
    meses_pt_en = {
        'Jan': 'Jan', 'Fev': 'Feb', 'Mar': 'Mar', 'Abr': 'Apr', 'Mai': 'May', 'Jun': 'Jun',
        'Jul': 'Jul', 'Ago': 'Aug', 'Set': 'Sep', 'Out': 'Oct', 'Nov': 'Nov', 'Dez': 'Dec'
    }
    for mes_pt, mes_en in meses_pt_en.items():
        if mes_pt in date_str:
            date_str = date_str.replace(mes_pt, mes_en)
    # Tentar duas possíveis formatações
    try:
        date = pd.to_datetime(date_str, format='%b-%y')
    except ValueError:
        try:
            date = pd.to_datetime(date_str, format='%b/%y')
        except ValueError:
            return None
    return date.strftime('%m-%Y')