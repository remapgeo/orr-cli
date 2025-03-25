
from orr_cli.logger import logger
from orr_cli.config import settings
from orr_cli.model import UserType
from orr_cli.db import engine
import pandas as pd


def metadataUser(user = settings['DB_USER']):
    
    m = pd.read_sql(f"SELECT * from orr_metadata.institutions where name = '{user.replace('_user','')}';", engine)
    if len(m) > 0:
        return m.iloc[0]
    return None

def check_user():
    user = settings['DB_USER']
    if user == 'orr_master':
        return UserType.MASTER
    USERS = metadataUser()
    if not USERS is None and user.endswith('_user'):
        return UserType.TEC
    return UserType.INVALID

def exists_user(user):
    if user == 'orr_master':
        return UserType.MASTER
    USERS = metadataUser(user)
    
    if not USERS is None and user.endswith('_user'):
        return UserType.TEC
    return UserType.INVALID