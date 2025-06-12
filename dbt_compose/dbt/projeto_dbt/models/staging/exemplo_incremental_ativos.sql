{{
    config(
        schema='staging',
        alias='exemplo_incremental_ativos'
    )
}}

--ID_ATIVO,DS_ATIVO,ID_SETOR,DS_SETOR,DS_DESCRICAO,ID_ATIVO1,DEFENSIVA

with source as (
    select 
    id_ativo AS id_ativo,
    ds_ativo AS ativo,
    id_setor AS id_setor,
    ds_setor AS ds_setor,
    ds_descricao as ds_descricao,
    id_ativo1 AS id_ativo1,
    defensiva AS defensiva
    from {{ ref('raw_ativos') }}
),

-- Padronização dos nomes das colunas 

renamed as (
    select 
        id_ativo,
        ativo,
        id_setor,
        ds_setor,
        ds_descricao,
        id_ativo1,
        defensiva
    from source
)

select * from renamed

{% if is_incremental() %}
WHERE
    id_ativo > (SELECT MAX(id_ativo) FROM {{ this }})
{% endif %}
