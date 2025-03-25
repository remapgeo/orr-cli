# Registering the correspondence between the columns used in the spatial files and the columns in the Database


| DataBase column| Vector column |  Template          | CLI allows you to upload blank/missing column | CLI can fill in the gaps <sup>1<sup> |
|:-------------: |:---------------: | :---------------: | :---------------: |        :---------------: | 
| categoria  | Categoria |        ORR e PACTO    |No.   | No. User must fill in |
| dat_inicio | DataInici |    ORR e PACTO  | No. <sup>3<sup>           | No. User must fill in |
| dat_concl | DataConcl |   ORR e PACTO | No. <sup>3<sup> | No. User must fill in |
| fonte<sup>2<sup>  | Fonte | ORR e PACTO | No.<sup>3<sup>  | No. User must fill in |
| inst_exec | InstExecu | ORR e PACTO | No.<sup>3<sup> |  No. User must fill in |
| inst_finan| InstFinan | ORR e PACTO |Yes | No. User must fill in |
| inst_gest | InstGest| ORR e PACTO |Yes | No. User must fill in |
| link  | Link  | ORR e PACTO |Yes | No. User must fill in |
| id |   IDNum | ORR e PACTO |Yes | Yes. CLI will generate the ID |
|met_princ | MetPrinc   | ORR e PACTO | No <sup>3<sup> | No. User must fill in|
|met_comb | MetComb   |  ORR e PACTO |Temporarily yes |Yes. 'Not identified'|
|
|monitorada | Monitora   |  ORR e PACTO | Temporarily yes | Yes. 'Not identified'|
|motivacao | Motivacao   | ORR e PACTO | Temporarily yes | Yes. 'Not identified'|
|projeto | Projeto   | ORR e PACTO | Temporarily yes | Yes. 'Not identified'|
|nm_projeto | NmProjeto   | ORR e PACTO | Temporarily yes | No. User must fill in |
|proj_ativo | ProjAtivo   | ORR e PACTO | Temporarily yes | Yes. 'Not identified'|
|tipo_area | TipoArea   | ORR e PACTO | Temporarily yes | Yes. 'Not identified'|
|tipo_reflo | TipoReflo   | ORR | Temporarily yes | Yes. 'Not identified'|
|esp_reflo | EspReflo   | ORR |Yes | No. User must fill in |
|privac_area | Privacidad   | ORR e PACTO | Temporarily yes | Yes. 'Not defined'|
|area_decl | AreaHa   | ORR e PACTO | Yes | No. The DataBase will generate the area_calc column |
|ano_prev | AnoPrevist   | PACTO | Yes | No. User must fill in |
|ano_prev_t | AnoPrevTe   | PACTO | Yes | No. User must fill in |
|prot_monit | ProtMonit   | PACTO | Yes | No. User must fill in |
|freq_monit | FreqMonit   | PACTO | Yes | No. User must fill in |
|uso_ant | UsoAnt   | PACTO | Yes | Yes. 'Not identified' |


<sup>1<sup> If the column doesn't exist, the CLI can create it and automatically fill it in with Not identified or the appropriate option for when it's blank. Some columns are completely compulsory to fill in, such as categoria and metod_princ (main method), in which case the CLI will just return an error warning the user to refill.

<sup>2<sup> The source here must be marked by the user according to the rules decided. In the database there will be a **fonte_schema** column which will ensure that the reporting collective is always traced, according to the user used to upload the information (Amazon Alliance, Araticum, Atlantic Forest Pact, Pantanal Pact, ReCaa, Southern Network or the ORR).

<sup>3<sup> 
The CLI can accept it provisionally and leave it as **Not identified** or **blank**, but the ideal is to have at least this columns registered.


