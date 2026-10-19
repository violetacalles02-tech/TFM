# nhanes
nhanes OMOP


https://zenodo.org/records/20032095


## TODO

- load NHANES in raw
- pivot tables
- map variables with usagi
    - Examination_var 
    - Laboratory_var 
    - Dietary_var: no tenenemos ningun archivo .xpt de este csv -> no mapeado
    - Questionary_var : mapeado las variables indicadas
 
## Nhanes DB
    1. Crear la base de datos nhanes_db
    2. Cargar los .xpt con el script en el schema raw
    3. Crear el schema base, y utilizar la query para pivotar las tablas, ahora teniendo tres columnas: id, variable_name, value
    4. Cargar los vocabularios de OHDSI al schema vocabularies
    5. Hacer el csv de mapeado con Usagi. Los he unido los tres csv a 1 solo con todas las variables, 
        indicando el domain_id (condition/observation/measurement) y la tabla a la que pertenece cada variable
    6. Adaptar las querys stg a nuestra base de datos
    7. Dbt seed & dbt run
