![project logo](assets/logo.png){width="250" class="centre"}
# Cli OBSERVATORY OF RESTORATION AND REFORESTATION

To configure the environment you must set the configuration variables in the **settings.toml** file
```toml
DB_NAME = 'dbname'
DB_USER = 'user'
DB_PASSWORD = 'password123'
DB_HOST = 'localhost'
DB_PORT = 3356
```

You can also set it as an environment variable using the prefix "ORR_"

```bash
export ORR_DB_NAME='dbname'
```

To install in a new database use the command 
```bash
orr install
```