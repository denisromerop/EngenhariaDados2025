{{
    config(
        schema='staging',
        alias='exemplo_incremental_movativos'
    )
}}

with source as (
    select 
    ativo as ativo,
    datamov as datamov,
    datestr as datestr,
    data_anomesdia as data_anomesdia,
    valor_open as valor_abertura,
    high as valor_pico,
    low as valor_baixo,
    valor_close as valor_final,
    volume as volume
    from {{ ref('raw_movativos') }}
),

-- Padronização dos nomes das colunas    Ativo,Datamov,DateStr,Data_AnoMesDia,Valor_Open,High,Low,Valor_Close,Volume

renamed as (
    select 
        ativo,
        datamov,
        datestr,
        data_anomesdia,
        valor_abertura,
        valor_pico,
        valor_baixo,
        valor_final,
        volume
    from source
)

select * from renamed

{% if is_incremental() %}
WHERE
    data_anomesdia > (SELECT MAX(data_anomesdia) FROM {{ this }})
{% endif %}
