
# Documentation of the tables and inserts developed for the DB - about the OPTIONS

**Options** refer to the column configurations established, since the Database was designed with the ability to accept both mandatory ORR columns and columns customized by collectives or institutions.
   
**The default template contains all the minimum columns of the ORR, ensuring uniformity of information related to restoration areas.

**Other templates may include additional customized columns in addition to the minimum ORR columns. Each column with an option becomes a table in the options schema.

 *Currently only the Atlantic Forest Pact has extra columns planned, which is why there are two folders in options: *default* and *pacto_ma*. Other partners will be able to develop their own models and these will be added.
      
# Standardization of option tables:

The options tables were planned together with ORR and its collaborators throughout the development of the DB.   

They serve to store the answers established by the institutions, ensuring that partners do not fill in the same information in different ways.    

## Each table corresponds to a piece of information that has been deemed necessary regarding the data entered into the DB. 

## Columns
All tables have 4 columns with the following information: 

- **name_key** : This is the first column that refers to a unique key written to identify an option given to a column. It is made up of the column abbreviation as a prefix and part of the option text as a suffix. Example: the main restoration method 'Agroforestry Systems (SAFs)' will have its name_key **'met_rest_saf'**. 

- **code_key** : This is the second column used to store information in the DB in a simple and effective way. It consists of 3 letters and 2 numbers, for example: **'mrs10'**. The code used in this column aims to reduce the space taken up in the 'features' tables and ensure that this data is in line with what is required.   

- **en** and **en** : The en and en columns are filled in with a description of the categories covered by each column. They are described in full in Brazilian Portuguese and English. An example of the application of the columns is given for the main restoration method table, where in column **en** the category is described as **'Agroforestry Systems (SAFs)'** and in column **en** its English translation is described as **'Agroforestry Systems (SAFs)'**. These columns are designed to be more human friendly and to guarantee future translations.

## Rows
The options tables contain in their rows the categories of each piece of information that a given table covers.

## Application example:

The **metod_princi** table's function is to identify the Main Restoration Method. This table contains a variety of restoration methods, each of which is described in a row in the **name_key** column:
- Direct seeding
- Agroforestry systems (SAFs)
- Natural Regeneration with Management

Using the method 'Agroforestry Systems - SAF' as an example, in this case, the method can also be described as 'SAFs' or as 'Agroforestry Systems (SAFs). To avoid these variations in nomenclature and descriptions leading to misinterpretation, the user will opt for one of the categories already defined. In this example case, it will be "Agroforestry Systems - SAF".    

By choosing the option 'Agroforestry Systems (SAFs)', this category will have a unique code defined by the **code_key** column, which in this case is **mrs10**. This code helps organize the DB and may help those filling in the information.




