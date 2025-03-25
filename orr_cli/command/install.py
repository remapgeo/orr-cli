from glob import glob

import psycopg2
from psycopg2 import sql
from rich.console import Console
from rich.progress import track
from rich.progress import Progress
from rich.table import Table
from typer import Typer
import geopandas as gpd
from sqlalchemy import create_engine


from orr_cli.config import ROOT_DIR, db_params, db_url
from orr_cli.command.institutions import new
from orr_cli.model import MHIDRO, MREGIAO
from orr_cli.utils.callbak import isMaster
from orr_cli.logger import logger


console = Console()



app = Typer(help="Install the database" , callback=isMaster)

def loop_install_sql(path, table, description=''):
    for file in track(
        sorted(glob(f"{ROOT_DIR}/{path}/**/*.sql", recursive=True)),
        description=description,
    ):
        with psycopg2.connect(**db_params) as conn:
            conn.autocommit = True
            with conn.cursor() as cur:

                with open(file, "r",  encoding="utf8") as f:
                    name_file = file.replace('\\','/').split("/")[-1]
                    try:
                        cur.execute(f.read())
                        table.add_row(name_file, "OK", "")
                        logger.debug(f"{name_file} installed")
                    except psycopg2.errors.DuplicateSchema as e:
                        logger.warning(f'{file}: {e}')
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    except psycopg2.errors.DuplicateFunction as e:
                        logger.warning(f'{file}: {e}')
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    except psycopg2.errors.DuplicateObject as e:
                        logger.warning(f'{file}: {e}')
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    except psycopg2.errors.DuplicateObject as e:
                        logger.warning(f'{file}: {e}')
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    except psycopg2.errors.UniqueViolation as e:
                        logger.warning(f'{file}: {e}')
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    except psycopg2.ProgrammingError as e:
                        if str(e) == "can't execute an empty query":
                            logger.warning(f'{file}: {e}')
                        else:
                           logger.exception(e) 
                        table.add_row(
                            name_file, "[yellow]FAIL[/]", str(e)
                        )
                    
                    except Exception as e:
                        table.add_row(
                            name_file, "[red]FAIL[/]", str(e)
                        )
                        logger.exception(f"{file}: failed to install {e}")





@app.command()
def init():
    """Install the database"""
    table = Table(title="Install the database")
    table.add_column("File", style="yellow", no_wrap=True)
    table.add_column("Status", style="green", no_wrap=True)
    table.add_column("Error", style="red", no_wrap=True)
    
    
    with psycopg2.connect(**db_params) as conn:
        conn.autocommit = True  # Habilitar o modo de confirmação automática
        
        with conn.cursor() as cur:
            try:
                cur.execute(
                    sql.SQL(
                        """
                        CREATE EXTENSION IF NOT EXISTS postgis;
                        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
                        """
                    )
                )
                
                table.add_row("postgis", "OK", "")
            except Exception as e:
                table.add_row("postgis", "[red]FAIL[/]", str(e))
                console.print(f"[red]Error ao installar postgis: {e}[/red]")
                
    loop_install_sql('scripts', table, "Installing orr tables:")
    
    engine = create_engine(db_url)

    with Progress() as progress:
        task = progress.add_task("Carregando dados hidrografia e região", total=5)
        progress.advance(task)
        # leitura 
        progress.console.print("Carregando Região do Brasil")   
        REGIAO = gpd.read_file(f'{ROOT_DIR}/data/regions.gpkg').to_crs(4674)
        REGIAO['cd_country'] = 1
        REGIAO['geometry'] = REGIAO['geometry'].make_valid()
        progress.advance(task)
        # leitura
        progress.console.print("Carregando Hidrografia do Brasil")  
        HIDRO = gpd.read_file(f'{ROOT_DIR}/data/hidro_regions.gpkg').to_crs(4674)
        HIDRO['objectid'] = HIDRO.index
        HIDRO['geometry'] = HIDRO['geometry'].make_valid()
        progress.advance(task)
        
        # salve db
        progress.console.print("Salvando no banco Região do Brasil")   
        REGIAO.to_postgis(
            name='regions', 
            con=engine,
            schema='orr_metadata',
            if_exists='replace',
            dtype=MREGIAO)
        progress.advance(task)

        # salve db
        
        progress.console.print("Salvando no banco Hidrografia do Brasil")  
        HIDRO.to_postgis(
            name='hidro_regions', 
            con=engine, 
            schema='orr_metadata', 
            if_exists='replace', 
            dtype = MHIDRO)
        progress.advance(task)

    """ Orr Install sistemy
    uandp para instalar os dados do orr
    """
    new('orr', db_params['password'], 'default')
    loop_install_sql('hook/orr',table, "ORR create informations:")
    
    loop_install_sql('hook/pos-install',table, "Pos-install")
    
    console.print(table)                        
    
