
from rich.console import Console

from typer import  Context, Exit, Option, Typer


from orr_cli import __version__
from orr_cli.command import files, install, institutions


console = Console()
app = Typer()

app.add_typer(
    install.app,
    name="install",
)
app.add_typer(files.app, name="file")
app.add_typer(institutions.app, name="institution")


def version_func(flag):
    if flag:
        console.print(f"version: {__version__}")
        raise Exit(code=0)


@app.callback(invoke_without_command=True)
def main(
    ctx: Context,
    version: bool = Option(False, callback=version_func, is_flag=True),
):
    message = """CLI para criar novas instituições e gerenciar banco de dados das instituições (redes biomáticas e instituições individuais).
"""
    if ctx.invoked_subcommand:
        return
    console.print(message)
