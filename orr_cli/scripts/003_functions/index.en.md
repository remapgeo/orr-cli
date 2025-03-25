
# Documentation of the functions developed for the DB

## *Functions with the prefix 'get' or 'ob_get':*
Developed to facilitate geospatial analysis in the context of regions or polygons, in addition to the characteristics of a given table. They 'get' the regions to which the polygons belong by extracting specific information.
 
 - *get_regions*: responsible for identifying the most common regions defined by the IBGE, such as municipalities, states, biomes, etc;
 - *get_hidro*: responsible for identifying Brazil's macro, meso and micro hydrographic regions;
 - *ob_get_interesection*: checks the intersection between two geometries (area of interest and features) and returns true if the intersection exceeds a specified minimum area or a percentage of the feature polygon;
 - *ob_get_colides*: determines whether two geometries have a significant collision based on a minimum percentage of the intersection or a minimum area of intersection - serves to demonstrate to the analyst/manager that there are geometries with some kind of interference;
 - Get_fetures_all_by_schema*: Returns all the rows of a given feature table, together with their metadata, based on the name of the schema provided, used to join the restoration areas for the ORR and other schemas whose area of interest is Brazil;
  - *ob_get_fetures_by_schema*: similar to the get_fetures_all_by_schema function, but returns only the rows of a table of features based on the name of the schema provided.

## *Function date_format:*
 The decision to create the function comes from the fact that partners don't have a date standard. Therefore, the function normalizes the dates by filling in those that do not have a day and/or month with the value **01**. 
Thanks to the record of the date structure, the dates filled in are only for the bank's internal control. 

 - *date_format*: formats an input date in different date formats based on a variety of standards, recognizing different input formats.

**The Materialized Views of each schema, which are the final product to appear on the platforms, will show the information found in each partner in the standardized date format with a column indicating whether the format was complete, month-year or just year so that the frontend can present it in the best way.**

Below is an example of a partner who only had YEAR, indicated by **y**.

![alt text](assets/image.png)

## *Functions with 'add' prefix:*
Developed to add information to the DB.
 
 - *ob_add_feture*: adds a new entity with various properties (geometric and metadata) to a features table. It automatically calculates and inserts the columns associating the region and hydrography associated with the geometry. In addition, the function inserts the status of the new line as **PENDING** so that it can be evaluated.
 - ob_add_feture_ma*: similar to the ob_add_feture function, but with additional columns specific to the Atlantic Forest Pact. In addition, the function inserts the status of the new line as **PENDING** so that it can be evaluated.

## *Other functions:*

 - *verificar_codigo_interesse_interna*: checks if a number is present in a matrix of numbers passed as a parameter;
 - *ob_verificar_codigo_interesse*: checks whether a geometry is contained in an area of interest specified by a schema, using a series of conditions and calling the verificar_codigo_interesse function;
 - *ob_insert_status*: inserts or updates the status of a particular row (identified by a UUID) in a status table. The status can be 'PENDING' 'APPROVED' or 'REJECTED';
 - *is_circle*: calculates a value between 0 and 1 to indicate how close a geometry is to being a perfect circle. Designed to identify geometries that have been generated using points, for example with a buffer, and may be a geometry with a non-precise area;
 - *is_triangle*: checks whether a geometry is a triangle by checking that it consists of exactly three points.
  - *permission*: ensures that the appropriate privileges are applied to each user/schema;
 - *refresh_materialized_views*:  will refresh all MVs of interest to biomatic networks/institutions - format notification, notification of very small/very large areas, notification of intersections/possible topological errors and summary of all restoration areas with 'APPROVED' status. 


# Regions table databases

## Regions table
Sourced from the Image Processing and Geoprocessing Laboratory (LAPIG), which summarises several important regions for Brazil, updated in 2022. 

## Hidro_regions table 
This is sourced from the National Water and Basic Sanitation Agency (ANA), which presents the National Hydrographic Division produced in partnership with the Brazilian Institute of Geography and Statistics (IBGE) and published in 2021.

The tables are summarised below.
| Geographical region | Source | Compiled by LAPIG |
|:-------------: |:---------------: | :-------------: |
| Municipalities | IBGE (2022) | yes |
| States | IBGE (2022) | yes |
| Region | IBGE (2022) | yes |
| Country | IBGE (2022) | yes |
| Legal Amazon | IBGE (2022) | yes |
| MATOPIBA | IBGE (2022) | yes |
| AMACRO | IBGE (2022) | yes |
| Hydrographic Macroregions | ANA/IBGE (2021) | no |
| Hydrographic Mesoregions | ANA/IBGE (2021) | no |
| Hydrographic Microregions | ANA/IBGE (2021) | no |