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


def execute_function(cursor, area_interest, features_geom, porcent_threshold=10, area_ha=1):
    """Executa a função ob_get_interesection e retorna o resultado"""
    cursor.execute(
        """
        SELECT ob_get_interesection(
            ST_SetSRID(%s::geometry, 4674),
            ST_SetSRID(%s::geometry, 4674),
            %s,
            %s
        );
        """,
        (area_interest, features_geom, porcent_threshold, area_ha)
    )
    return cursor.fetchone()[0]


def test_ob_get_interesection_false(db_connection):
    """Teste que espera retorno False da função"""
    cursor, _ = db_connection
    area_interest = "POLYGON((0 0, 0 1, 1 1, 1 0, 0 0))"
    features_geom = "POLYGON((5 5, 5 15, 15 15, 15 5, 5 5))"

    result = execute_function(cursor, area_interest, features_geom)
    assert result is False

def test_ob_get_interesection_false(db_connection):
    """Teste que espera retorno False da função"""
    cursor, _ = db_connection
    area_interest = "POLYGON((0 0, 0 1, 1 1, 1 0, 0 0))"
    features_geom = "POLYGON((5 5, 5 15, 15 15, 15 5, 5 5))"

    result = execute_function(cursor, area_interest, features_geom)
    assert result is False
