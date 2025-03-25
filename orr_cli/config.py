import pathlib
import psycopg2

from dynaconf import Dynaconf
from jinja2 import Environment, FileSystemLoader


settings = Dynaconf(
    envvar_prefix="ORR",
    settings_files=["settings.toml", ".secrets.toml"],
    environments=True,
    load_dotenv=True,
)


ROOT_DIR = pathlib.Path(__file__).parent.resolve()
TEMPLATES_DIR = f"{ROOT_DIR}/template"

templets = Environment(loader=FileSystemLoader(searchpath=f"{ROOT_DIR}/template"))

db_params = {
    "dbname": settings.DB_NAME,
    "user": settings.DB_USER,
    "password": settings.DB_PASSWORD,
    "host": settings.DB_HOST,
    "port": settings.DB_PORT,
}

db_url = f'postgresql://{settings.DB_USER}:{settings.DB_PASSWORD}@{settings.DB_HOST}:{settings.DB_PORT}/{settings.DB_NAME}'
# `envvar_prefix` = export envvars with `export DYNACONF_FOO=bar`.
# `settings_files` = Load these files in the order.




def get_db_connection():
    return psycopg2.connect(
        dbname=settings.DB_NAME,
        user=settings.DB_USER,
        password=settings.DB_PASSWORD,
        host=settings.DB_HOST,
        port=settings.DB_PORT
    )
