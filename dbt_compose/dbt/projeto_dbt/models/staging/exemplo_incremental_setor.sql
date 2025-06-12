{{
    config(
        schema='staging',
        alias='exemplo_incremental_setor'
    )
}}

with source as (
    select 
    id_setor AS id_setor,
    ds_setor AS ds_setor,
    id_setor1 AS id_setor1,
    ds_setor_ok AS ds_setor_ok
    from {{ ref('raw_setor') }}
),

-- Padronização dos nomes das colunas   ID_SETOR,DS_SETOR,ID_SETOR1,DS_SETOR_OK

renamed as (
    select 
        id_setor,
        ds_setor,
        id_setor1,
        ds_setor_ok    
    from source
)

select * from renamed

{% if is_incremental() %}
WHERE
    id_setor > (SELECT MAX(id_setor) FROM {{ this }})
{% endif %}
