import pytest
from orr_cli.config import get_db_connection


@pytest.fixture(scope="module")
def db_connection():
    # Configuração do banco de dados
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Retorna a conexão e o cursor para os testes
    yield cur, conn
    
    # Teardown do banco de dados
    cur.close()
    conn.close()

def test_base(db_connection):
    cur, conn = db_connection
    # Seu teste real pode ser adicionado aqui
    assert 1 == 1

    
