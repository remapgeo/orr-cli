from psycopg2 import sql

from rich.console import Console
from rich.table import Table



console = Console()

import re



def is_url(s):
    if s is None:
        return True
    regex = re.compile(
        r'^(?:http|ftp)s?://' # http:// or https://
        r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' #domain...
        r'localhost|' #localhost...
        r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' # ...or ip
        r'(?::\d+)?' # optional port
        r'(?:/?|[/?]\S+)$', re.IGNORECASE)
    return re.match(regex, s) is not None


def is_valid_caracter(text):
    pattern = r'^[a-zA-Z0-9-\s\u00C0-\u017F–/\(\),.:_@;\'\&]+$'
    return bool(re.match(pattern, text))

def check_caracter(x):
    try:
        y = int(x)
        return False
    except:
        if x is None:
            return False
        if isinstance(x, (float, int)):
            return False
        if '\\x' in repr(x):
            return True
        if is_valid_caracter(x):
            return False
        return True


def file_to_name(file: str) -> str:
    """Convert file name to name para rich table

    Args:
        file (str): File name

    Returns:
        str: Name for rich table
    """
    return file.replace('\\','/').split("/")[-1].split(".")[0][4:-1].replace("_", " ")


def creat_new_user_and_schema(new_user: str, new_password: str):
    """Create a new user and schema

    Args:
        new_user (str): New user name and schema name
        new_password (str): Password for new user
    """
    return [
        (f"CREATE USER {new_user}_user WITH PASSWORD '{new_password}'", "creat user"),
        (
            sql.SQL("CREATE SCHEMA {}").format(sql.Identifier(new_user)),
            "creat schema",
        ),
        (
            sql.SQL("GRANT ALL PRIVILEGES ON SCHEMA {} TO {}").format(
                sql.Identifier(new_user), sql.Identifier(f"{new_user}_user")
            ),
            f"grant privileges {new_user}_user",
        ),
        (
            sql.SQL(f'GRANT ALL PRIVILEGES ON SCHEMA {new_user} TO "orr_master"'),
            "grant privileges orr_master",
        ),
    ]


def validate_password(password: str) -> bool:
    """Validate password

    Args:
        password (str): Password para verificar se é valido

    Returns:
        bool: True if password is valid
    """
    a_set = set()
    min_length = 8

    table = Table(title="Error password!")
    table.add_column("error", style="red", no_wrap=True)

    error = False

    if len(password) < min_length:
        table.add_row("Insufficient length")
        error = True
    for char in password:
        # Checking alphabet: a-z A-Z is in password characters
        if char.isalpha() == True:
            a_set.add("letter")
            continue
        # Check for numbers 0-9
        elif char.isdigit() == True:
            a_set.add("number")
            continue
        # Check for symbol (not alphanumeric)
        elif char.isalnum() == False:
            a_set.add("symbol")
            continue
        else:
            console.print("User may use a non ASCII keyboard!")
            return False
    # Check if all: letter, number and symbol in the set

    if "letter" not in a_set:
        table.add_row("No letter in password!")
        error = True
    if "number" not in a_set:
        table.add_row("No number in password!")
        error = True
    if "symbol" not in a_set:
        table.add_row("No symbol in password!")
        error = True

    if error:
        console.print(table)
        return False

    return True
