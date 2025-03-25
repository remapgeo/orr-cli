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


@pytest.mark.parametrize(
    "date_input, expected_date, expected_format_type",
    [
        ('15/03/2023', '2023-03-15', 'dmy'),
        ('03/2023', '2023-03-01', 'my'),
        ('2023/03', '2023-03-01', 'my'),
        ('2023', '2023-01-01', 'y'),
        ('2023-03-15', '2023-03-15', 'dmy'),
        ('2023-03', '2023-03-01', 'my')
    ]
)
def test_date_format(db_connection, date_input, expected_date, expected_format_type):
    cur, _ = db_connection
    cur.execute("SELECT * FROM public.ob_date_format(%s);", (date_input,))
    result = cur.fetchone()

    # Verifica se o retorno foi correto
    assert result is not None, "A função não retornou nenhum valor"
    formatted_date, format_type = result
    assert str(formatted_date) == expected_date, f"Data formatada incorreta para '{date_input}'"
    assert format_type == expected_format_type, f"Formato incorreto para '{date_input}'"


def test_invalid_date(db_connection):
    cur, _ = db_connection
    cur.execute("SELECT * FROM public.ob_date_format(%s);", ('invalid-date',))
    result = cur.fetchone()

    # Verifica o resultado para data inválida
    assert result[0] is None, "Data inválida deveria retornar NULL"
    assert result[1] is None, "Formato inválido deveria retornar NULL"