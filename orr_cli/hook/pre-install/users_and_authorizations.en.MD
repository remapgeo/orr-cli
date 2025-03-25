# Summary of users and permissions for each registration category

There are currently seven (7) schemas in which restoration areas can be inserted. There are six (6) schemas that correspond to the Brazilian biomes + the ORR schema. There are 2 suffixes provided for users: **_master** and **_user**. In the future it will be possible to develop more categories of users according to the needs identified.

**It's important to understand that the database was developed for ensure that any geographical unit can be an area of interest for an group. Initially, the users will only work with the biome scale but they can flexibilize or add new schemas/groups that will work with cities, states, watersheds etc.**

| User| Suffix scheme |  Allowed actions      |     Biome |
|:-------------: |:---------------: | :---------------: |  :---------------: |
| orr_master | **_master** | create schemas, users, change passwords; create and change tables, functions and VMs of all bank schemas; select from all tables; permission to call all functions | All biomes |
| orr_user | **_user** | select from all tables in the database; permission to change the features and status_features tables in the 'orr' schema; permission to call functions | All biomes |
| aliancaamz_user | **_user** | select in all tables of the database; permission to change the features and status_features tables of the 'aliancaamz' schema; permission to call functions | Amazon biome |
|araticum_user | **_user** | select in all tables of the database; permission to change the features and status_features tables of the 'araticum' schema; permission to call functions | Cerrado biome |
|pactoma_user | **_user** | select in all tables of the database; permission to change the features and status_features tables of the 'pactoma' schema; permission to call functions | Atlantic forest biome |
|pactopant_user | **_user** | select from all tables in the database; permission to change the features and status_features tables in the 'pactopant' schema; permission to call functions | Pantanal biome |
|recaa_user | **_user** | select from all tables in the database; permission to change the features and status_features tables in the 'recaa' schema; permission to call functions | Caatinga biome |
|redesul_user | **_user** | select in all database tables; permission to change the features and status_features tables of the 'redesul' schema; permission to call functions | Pampa biome |