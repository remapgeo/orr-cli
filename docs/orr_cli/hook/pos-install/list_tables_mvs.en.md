# List of tables and Materialized Views

## Tables present in all schemas


Each institution will have the following list of tables
- **features**: Table that stores all the restoration areas of the schema. **This table will only show the areas that have been entered by the user of the corresponding scheme. e.g. Pantanal Pact user (pactopant_user) will only enter and see the restoration areas compiled by the Pantanal Pact collective;

- **status_features**: Table that stores the uuid of all the restoration areas that are outside the Pantanal Pact scheme (pactopant), but which are within the Pantanal biome, registering them with a 'PENDING' status evaluation. It is from this table that the Pantanal Pact user will be able to make checks and decide whether they want these areas to be incorporated into their collective and appear on their geographic information site in the future. The check is made by choosing between 'APPROVED' and 'REJECTED';


- **features_estra_rest**: used to store the list of answers relating to restoration strategies for each feature line inserted in **features**.

- **features_met_comb**: intended to store the list of answers relating to secondary/combined methods for each feature line inserted in **features**.


## Materialized Views present in all schemas

- **mv_features**: This MV summarises all the restoration areas that have an 'APPROVED' status. It shows both the scheme's native restoration areas and those of other partners that are located within the scheme's area of interest. e.g. Pacto do Pantanal will have all the approved restoration areas, both those entered by pactopant_user and those entered in other schemes, but which are considered to be within the Pantanal biome;


- **mv_notificacao_area**: This MV notifies the scheme user of restoration areas that are too large (>200 ha) so that the user can validate whether it is a geometry that fulfils the restoration requirements.

- **mv_intersec_intern**: This MV notifies the schema user of restoration areas (ONLY FROM THE FEATURES TABLE) that have possible topological errors (intersection, contains, touches).


- **mv_notificacao_formato**: This MV notifies the user when triangle or circle shapes occur (ONLY FROM THE FEATURES TABLE) so that the user can check.

## Materialized view only in ORR schema

- **mv_intersec_all**: This MV will show the polygon intersections between different biomatic networks. It is exclusive to the Observatory, as it will be able to manage and check with each network/institution what has happened and how best to deal with it. Like mv_intersec_inters, it shows intersection, contains, is inside, touches. E.g. Rede Sul inserted a polygon that is intersecting a polygon with the Pantanal Pact. The ORR user will be able to talk to both networks and decide what should be done.