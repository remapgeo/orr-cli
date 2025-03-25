import pytest
from orr_cli.config import get_db_connection
from tests.data import data

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

def test_get_hidro(db_connection):
    cur, conn = db_connection
    # Geometria de teste em São Paulo
    cur.execute("SELECT public.get_hidro(ST_GeomFromText(%s, 4674));", (data['saopaulo'],))
    result = cur.fetchone()

    # Validação do resultado esperado
    expected_region_id = '(284,111,11150,11150272)'
    assert result is not None, "A função não retornou nenhum valor"
    assert result[0] == expected_region_id, f"Região esperada: {expected_region_id}, obtida: {result[0]}"
