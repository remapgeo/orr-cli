# Documentation of the functions developed for the DB

## *Triggers:*
Triggers are automatically fired in response to certain events, such as inserting, updating or deleting data in a table.
 
 - *ob_geometry_informations_trigger*: when a new geometry is added, the IBGE-based region is identified (municipality, state or biome) and the hydrographic region to which it belongs, then its area in hectares is calculated and this information is inserted into a new row in the "features" table;
  
 - *ob_update_date_modification*: every time a row in the "features" table is updated, the updated_at field is automatically updated with the current timestamp. This is useful for tracking when a row was last modified.