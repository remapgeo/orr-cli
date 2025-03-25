from orr_cli.utils.auth import check_user
from orr_cli.model import UserType
from rich.console import Console
import sys

console = Console()


def isMaster():
    if check_user() == UserType.MASTER: 
        return True
    console.print('User is not master')
    sys.exit(1)


def isTec():
    if check_user() == UserType.TEC: 
        return True
    console.print('User is not tec')
    sys.exit(1)
