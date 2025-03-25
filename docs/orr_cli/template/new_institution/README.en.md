
# **Documentation of Materialized Views and functions for creating the DB's main tables**

## *Materialized Views for controlling access to the DB:*.   
    
**Creation of "uuid" and "code_key" indexes**.
 - Creates table identifications to optimize queries based on schema columns, such as "features_met_comb" and "status_features".

**Ownership and granting of privileges:**
- Creat_status_feature: defines the owner and specific concessions for users, storing this information in a table.   
Three ALTER TABLE statements are used to change the owner of the "features", "features_met_comb" and "features_estra_rest" tables to "orr_master". This sets the user "orr_master" as the owner of these tables, ensuring control and security over them.    
And two GRANT statements are used to grant all privileges on the tables to the user "user", allowing full control over these tables, including permissions for SELECT, INSERT, UPDATE and DELETE.   
At the end, a "status_features" table is generated to store this information. This table is designed with a composite primary key and additional indexes to optimize queries related to "uuid", "schema_name" and "status".     
        
## *Materialized Views for Format Notifications:*
**In this set of scripts, Materialized Views are created to identify restoration areas with format problems, such as circles, triangles and lines, areas of dubious size. Also, to analyze the possibility of having inserted areas that correspond to the same location, or that are overlapping in order to evaluate them.:**
 - *ob_creat_mv_circle_trangle*: selects areas that have been defined as problematic shapes, such as circles, triangles and lines, and combines this information with the corresponding status of each area.
 
 - *ob_creat_mv_tamanho*: identifies areas with anomalous sizes, i.e. areas of less than 0.001 ha or more than 300 ha, and combines them with their respective statuses.
 
 - *ob_mv_features*: uses the ob_get_features_by_schema schema to retrieve the features of the specified schema. It stores the results of this query for quick and efficient access later.
 
 - *ob_mv_intersec_intern*: identifies intersections between areas, calculates the area of overlap, the percentage of overlap in relation to the original area by transforming them to a specific coordinate system and converting the unit to hectares, indicates whether the geometries intersect or just touch, whether one geometry is completely inside the other or whether one covers the other. Only shows the features owned by the institution of the specified schema.   