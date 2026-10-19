-- Para cada tabla del esquema raw, crea su equivalente pivotado en el
-- esquema base: mismo nombre de tabla, formato largo (person_id, variable,
-- value) en vez de una columna por variable.
--
-- Excluye automaticamente la columna seqn (se usa como person_id) y las
-- columnas de peso muestral (empiezan por "wt").
--
-- Ejecutar con: psql -f pivot_tables_to_base.sql
-- (o pegarlo directamente en tu cliente SQL)

create schema if not exists base;

do $$
declare
    tbl record;
    col record;
    sql_unpivot text;
    first_col boolean;
    n_cols integer;
begin
    for tbl in
        select table_name
        from information_schema.tables
        where table_schema = 'raw'
        order by table_name
    loop
        -- comprobar que la tabla tiene columna seqn
        if not exists (
            select 1 from information_schema.columns
            where table_schema = 'raw'
              and table_name = tbl.table_name
              and lower(column_name) = 'seqn'
        ) then
            raise notice '% : no tiene columna seqn, salto', tbl.table_name;
            continue;
        end if;

        sql_unpivot := '';
        first_col := true;
        n_cols := 0;

        for col in
            select column_name
            from information_schema.columns
            where table_schema = 'raw'
              and table_name = tbl.table_name
              and lower(column_name) <> 'seqn'
              and lower(column_name) not like 'wt%'
            order by ordinal_position
        loop
            if not first_col then
                sql_unpivot := sql_unpivot || ' union all ';
            end if;

            sql_unpivot := sql_unpivot || format(
                'select seqn::integer as person_id, %L::text as variable, %I::text as value from raw.%I where %I is not null',
                col.column_name, col.column_name, tbl.table_name, col.column_name
            );

            first_col := false;
            n_cols := n_cols + 1;
        end loop;

        if n_cols = 0 then
            raise notice '% : sin columnas de datos tras filtrar, salto', tbl.table_name;
            continue;
        end if;

        execute format('drop table if exists base.%I', tbl.table_name);
        execute format('create table base.%I (person_id integer, variable text, value text)', tbl.table_name);
        execute format('insert into base.%I %s', tbl.table_name, sql_unpivot);

        raise notice '% : pivotada (% variables)', tbl.table_name, n_cols;
    end loop;
end $$;
