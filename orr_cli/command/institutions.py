import sys
from orr_cli.model import UserType
from orr_cli.utils.auth import exists_user
from orr_cli.utils.callbak import isMaster
from rich.console import Console
from rich.progress import track
from rich.table import Table
from typer import Argument, Option, Typer

from orr_cli import __version__
from orr_cli.config import TEMPLATES_DIR, templets
from orr_cli.functions import (
    creat_new_user_and_schema,
    validate_password,
)
from orr_cli.db import execut_sql
from orr_cli.i18n import Translator
from orr_cli.logger import logger
from pathlib import Path


tl = Translator()


console = Console()
app = Typer(help=tl.translate("institution_help_menu"), callback=isMaster)


@app.command()
def new(
    name: str = Argument,
    password: str = Option(..., prompt=True, confirmation_prompt=True, hide_input=True),
    template: str = Option("default", help="Template to create the institution"),
):
    """Create a new institution"""
    if validate_password(password):
        console.print(f"[b]Creating institution {name}...[/]")
        table = Table(title="Install the database")
        table.add_column("Name", style="yellow", no_wrap=True)
        table.add_column("Status", style="green", no_wrap=True)
        table.add_column("Error", style="red", no_wrap=True)

        for i in track(
            creat_new_user_and_schema(name, password),
            description="Creating user and schema:",
        ):
            tmp = execut_sql(*i)
            table.add_row(*tmp)
        files = sorted([str(i) for i in Path(f'{TEMPLATES_DIR}/new_institution/{template}/').rglob('*.sql')])
        logger.debug(files)
        for file in track(files,
            description=f"Creating tables to {name}:",
        ):
            template_name = file.replace('\\','/').split("/template/")[-1]
            tmp = execut_sql(
                templets.get_template(template_name).render(schema=name),
                file=file
            )
            table.add_row(*tmp)
            if tmp[1] == "[red]FAIL[/]":
                console.print(f"[red]Error ao criar a template!\n{tmp[2]}[/red]")
        console.print(table)
        
        
@app.command()
def password(
    name: str = Argument,
    password: str = Option(..., prompt=True, confirmation_prompt=True, hide_input=True)
):
    """Create a new institution"""
    if validate_password(password):
        if exists_user(name) == UserType.TEC:
            execut_sql(f"ALTER USER {name} WITH PASSWORD '{password}';")
            console.print(f'Password changed to {name}')
            sys.exit(0)
    console.print('User information not valid')  
    sys.exit(1)
        
