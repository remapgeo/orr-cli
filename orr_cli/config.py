import os
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

DB_NAME = getattr(settings, "DB_NAME", os.getenv("ORR_DB_NAME", "postgres"))
DB_USER = getattr(settings, "DB_USER", os.getenv("ORR_DB_USER", "application"))
DB_PASSWORD = getattr(
    settings, "DB_PASSWORD", os.getenv("ORR_DB_PASSWORD", "application")
)
DB_HOST = getattr(settings, "DB_HOST", os.getenv("ORR_DB_HOST", "localhost"))
DB_PORT = getattr(settings, "DB_PORT", os.getenv("ORR_DB_PORT", 5432))

db_params = {
    "dbname": DB_NAME,
    "user": DB_USER,
    "password": DB_PASSWORD,
    "host": DB_HOST,
    "port": DB_PORT,
}

db_url = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
# `envvar_prefix` = export envvars with `export DYNACONF_FOO=bar`.
# `settings_files` = Load these files in the order.


def get_db_connection():
    return psycopg2.connect(
        dbname=settings.DB_NAME,
        user=settings.DB_USER,
        password=settings.DB_PASSWORD,
        host=settings.DB_HOST,
        port=settings.DB_PORT,
    )
