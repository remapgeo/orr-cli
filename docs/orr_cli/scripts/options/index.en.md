

# Documentation of the attribute definitions developed for the DB

## *Institution acronyms:*
- ORR* - Restoration and Reforestation Observatory  
- PACTO* - Pact for the Restoration of the Atlantic Forest 

## *Table attribute definitions:*
 The descriptions of the attributes of each table specified below were drawn up in agreement with the PACTO and ORR teams.

**Column**: IDNum.  
**Definition**: Sequential and unique number for each registered polygon.   
**Rules: The number will be unique for each polygon entered, it will not be repeated and, even if a particular polygon is removed, the number generated will not be used for another. This field will not be filled in by the user.   
**Restriction**: It's preferable that both PACTO and ORR adopt this column.

**Column**: Source.   
**Definition**: Source of the data (e.g. ORR, institution, etc).    
**Rules**: Will not be filled in by the user. It will always be filled in by PACTO from where the data was compiled.    
**Restriction**: Use only by PACTO.    


**Column**: IDPacto.   
**Definition: Polygon identification code generated by PACTO sequentially with PMA coding (e.g. PMA001).   
**Rules: Filling in Pact = sequential ID at each polygon insertion, ID is not repeated, even if the polygon is removed. Will not be filled in by the user.   
**Restriction**: Use only by PACTO.     

**Column**: category.
**Definition: Project/information category listed in the ORR.
**Rules: Filling in will have the following categories: Reforestation, Restoration, Secondary Vegetation and Unidentified. The answer option will initially only be "Restoration". The other categories have been generated for future use.    
**Restriction**: There is a specific table for PACTO. PACTO and ORR do not share the same category table, but both use this field.

**Column**: fonte_schema.   
**Definition**: Name of the institution that compiled the data.    
**Rules: The answer will always be "PACTO" or "ORR". The institution that reports and fills in the information.     
**Restriction**: Will not be filled in by the user in the case of PACTO data.      

**Column**: projeto.    
**Definition**: Name of the project to which the restoration area is linked.       
**Rules**: This must be filled in only once. If left blank, the answer will be "not identified". The options are: yes, no, not applicable and not identified.    
**Restriction**: Used equally by PACTO and ORR.    

**Column**: nm_projeto.   
**Definition: Name of the restoration program/project.    
**Rules**: Optional. The option to fill in is Conditional:
YES answer in "project link" is filled in by free text / NO is filled in as "not applicable" / blank fill in "not identified").   
**Restriction**: Used by PACT and ORR alike.    

**Column**: inst_exec.    
**Definition**: Name of the institution that carried out the restoration.
**Rules: This field cannot have a blank, not applicable or unidentified field. The option to fill it in is free text.     
**Restriction**: It is used equally by PACTO and ORR.    

**Column**: inst_gest.   
**Definition**: Institution that coordinated and contracted the executor of the restoration area.
**Rules**: This is a free text option.    
**Restriction**: Used equally by PACTO and ORR.    

**Column**: inst_finan.   
**Definition**: Name of the institution from which the financial resources for the restoration originate.    
**Rules: The option to fill in is optional and free text. If not filled in, it will be conditioned as "not identified".    
**Restriction**: Used equally by PACTO and ORR.    

**Column**: estra_rest.       
**Definition: Restoration strategy.    
**Rules**: This column is NOT visible to the user, it is conditioned in relation to the rule related to the "MetPrinc" column. It will be filled in according to the combination rule between the answers in the "main method" and "secondary method" columns.     
**Restriction**: Used equally by PACTO and ORR.    

**Column**: method_princi.   
**Definition: Main method used to restore the area.    
**Rules: Filling in is compulsory and only selectable. If not filled in, it will be conditioned with the option "not identified". The options are: Isolation, Control of competing plants, Densification, Enrichment, Nucleation, Direct seeding, Planting of seedlings and Agroforestry systems (SAFs) and Does not apply.    
**Restriction**: It is used equally by PACTO and ORR.    

**Column**: method_comb.      
**Fixed option**: This is a column conditioned by the tables in the options schema. 
**Definition: Auxiliary method conditional on the choice of the main method in the restoration (MetPrinc).    
**Rules**: Auxiliary methods conditioned on the choice of the main method in the restoration (MetPrinc). Completion is optional and multiple selection. If not filled in, the option "not identified" will be applied. The options are: Isolation, Control of competing plants, Densification, Enrichment, Nucleation, Direct seeding, Seedling planting, Agroforestry systems (SAFs) and Not applicable.    
**Restriction**: It is used equally by PACTO and ORR.    

**Column**: Motivation.    
**Definition: Main reason for the restoration.     
**Rules**: Mandatory and single-selection. If not filled in, the answer will be conditioned as not identified. The selection options are: environmental suitability, biodiversity, environmental compensation within the scope of licensing, environmental compensation within the scope of reparation for environmental crime, other infractions, carbon projects, PES projects, other economic factors, water resources, other objectives, voluntary restoration and not identified.   
**Restriction**: Used by PACT and ORR alike.    

**Column**: tipo_area.   
**Definition**: Main place where the restoration is carried out.   
**Rules: The option to fill in is unique and obligatory, with one of the options being chosen: Unidentified (when not filled in), Legal Reserve - RL, Legal Reserve Surplus Area - ERL, Permanent Preservation Area - APP, Mandatory Forest Replacement Area, Forest Easement Area, Alternative Use Area, Consolidated Use Area, Rural Settlements, Indigenous Lands, Quilombola Lands, UC Biological Reserve - REBIO, UC National Park - PARNA, UC Natural Monument - MONA, UC Wildlife Refuge - RVS, UC Environmental Protection Area - APA, UC Area of Relevant Ecological Interest - ARIE, UC National Forest - FLONA, UC Extractive Reserve - RESEX, UC Fauna Reserve - RF, UC Sustainable Development Reserve - RDS, UC Private Natural Heritage Reserve - RPPN, others.    
**Restriction**: Used equally by PACTO and ORR.   

**Column**: use_solo_ant_ma.   
**Definition: Land use and occupation prior to restoration activities.    
**Rules**: Filled in optionally and only selected. If not filled in, the option of not identified will be applied. The options are:
Agriculture, forest, pasture, natural regeneration, forestry, exposed soil, other and not identified.   
**Restriction**: Use restricted to PACT data.


**Column**: tipo_reflo.    
**Definition**: Type of reforestation/forestry.    
**Rules: Filling in is by single selection, the options being: Consortium Planting of Native and Exotic Species, Crop-Livestock-Forest Integration (ILPF), Monoculture Planting of Exotic Species, Monoculture Planting of Native Species, Unidentified and Other.     
**Restriction**: Used equally by PACTO and ORR. However, it will not be filled in by PACTO.    

**Column**: esp_reflo.   
**Definition: Name of the species planted in reforestation/forestry.    
**Rules**: Free to fill in and not compulsory.   
**Restriction**: Used equally by PACTO and ORR. However, it will not be filled in by PACTO.

**Column**: date_ini.    
**Definition**: Date on which restoration activities began.     
**Rules**: This must be filled in. The date must be filled in with day, month and year (dd/mm/yyyy). In the future on the frontend, when the DB is deployed on the platform/website, the plan is for the date to be shown only in year or month/year format.     
**Restriction**: It is used equally by PACTO and ORR.    

**Column**: proj_ativo.     
**Definition**: Informs whether the restoration project has activities in progress.      
**Rules: Filling in is compulsory and only selectable. If not filled in, the answer will be "Not identified". The options are: yes, no, not applicable and not identified.     
**Restriction**: Used equally by PACTO and ORR.    

**Column**: dat_concl.    
**Definition**: Date of closure of restoration activities.    
**Rules**: Completion is compulsory and conditional on the "ProjAtivo" column following the rule: If YES is given in the "ProjAtivo" column, then it will be filled in with 0 (zero), if the answer is NO, then the date will be filled in.     
**Restriction**: This is used equally by PACTO and ORR. However, for ORR the completion date will be unconditional.     

**Column**: ano_prev.    
**Definition**: Expected year of completion/end of the restoration project.     
**Rules: Compulsory and conditional: if the answer is YES to "active project" the year will be filled in, if the answer is NO the value 0 (zero) will be assigned.     
**Restriction**: Use only by PACTO.     

**Column: link.    
**Definition**: Link to access and/or about project information.    
**Rules: Optional, free-text field.     
**Restriction**: Used equally by PACTO and ORR.    

**Column**: area_decl.    
**Definition**: Declared area in hectares.     
**Rules**: Calculation in Datum reprojected to SAD 69.    
**Restriction**: Used equally by PACTO and ORR. However, for PACTO: the area calculation takes into account the Albers Brazil Equivalent Conic projection (IBGE).    

**Column**: monitora.     
**Definition: Indicates whether the area has field or remote restoration monitoring.
**Rules**: This must be filled in, with the options: yes, no and not identified (if the information is not filled in).     
**Restriction**: Used equally by PACTO and ORR.   

**Column**: privac_area.    
**Definition**: Indicates whether the area can be displayed on a public access map.     
**Rules**: This must be filled in with the following options: Public, Private and not defined (in case the information is not filled in).      
**Restriction**: Used equally by PACTO and ORR.    

**Column**: prot_monit.    
**Definition: Description of the type of monitoring protocol used to monitor the restoration area.      
**Rules**: Completion is compulsory and conditional on the "monitoring" column. The options for filling this in are: if the answer is YES in the "monitoring" column, this field will be filled in as free text; if the answer is NO in the "monitoring" column, this field will be filled in as "not applicable"; and if the information is not filled in, it will be assigned as "not identified".     
**Restriction**: Use only by PACTO.     
 

**Column**: freq_monit.   
**Definition**: Describes the frequency with which field monitoring is carried out in the restoration area.    
**Rules: Filling in is compulsory and conditional on the "monitoring" column. The options for filling this in are: if the answer is 
YES in the "monitoring" column, the entry in this field will be free text; if the answer is NO in the "monitoring" column, the entry in this field will be "not applicable"; and if the information is not filled in, it will be assigned as "not identified".    
**Restriction**: Use only by PACTO.   

**Column**: ano_prev_t.   
**Definition**: At what age do you intend to stop monitoring.   
**Rules**: Completion is compulsory and conditional on the "monitoring" column. The options for filling this in are: if the answer is YES in the "monitoring" column, this field will be filled in as free text; if the answer is NO in the "monitoring" column, this field will be filled in as "not applicable"; and if the information is not filled in, it will be assigned as "not identified".   
**Restriction**: Use only by PACTO.   