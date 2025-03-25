from typing import Tuple

import psycopg2
from psycopg2 import sql
from orr_cli.logger import logger
from orr_cli.config import db_params
from sqlalchemy import create_engine



engine = create_engine(
    f'postgresql+psycopg2://{db_params["user"]}:{db_params["password"]}@{db_params["host"]}:{db_params["port"]}/{db_params["dbname"]}'
)

def execut_sql(sql: str, file: str = "") -> Tuple[str, str, str]:
    """Executa uma query sql e retorna uma tupla com 3 elementos.
    Args:
        sql (str): SQL que serar executado.
    Returns:
        Tuple[bool, str, str]: retorna uma tupla com 3 elementos.
    """
    name = file.replace('\\','/').split('/')[-1]
    with psycopg2.connect(**db_params) as conn:
        conn.autocommit = True
        with conn.cursor() as cur:
            try:
                cur.execute(sql)
                return name, "OK", ""
            except Exception as e:
                logger.error(f'{file}\n Falhou {e}')
                return name, "[red]FAIL[/]", str(e)

