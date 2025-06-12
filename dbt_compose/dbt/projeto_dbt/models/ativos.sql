with ativos as (

    select * from {{ ref('exemplo_incremental_ativos') }}

),

setor as (

    select * from {{ ref('exemplo_incremental_setor') }}

),

movativos as (

    select * from {{ ref('exemplo_incremental_movativos') }}

),
--Ativo,Datamov,DateStr,Data_AnoMesDia,Valor_Open,High,Low,Valor_Close,Volume
movativos_mes as (

        select
        ativo as ativo,
        SUBSTRING(datestr,1,7) as anomes,
        Last(data_anomesdia) as datacotacao,
        Last(valor_close) as valor_close_mes
    from movativos

    group by ativo,  SUBSTRING(datestr,1,7) 

),

movativos_mes_completo as (

    Select
        ativos.id_ativo,
        ativo,
        anomes,
        datacotacao,
        ativos.id_setor,
        ativos.ds_setor,
        First(valor_close_mes) as valor_close_mes

    From movativos_mes

    left join ativos on
         movativos_mes.ativo = ativos.ds_ativo

    Group by movativos_mes.ativo, ativos.ds_ativo, movativos_mes.anomes

),

final as (

    select
        id_ativo,
        ativo,
        anomes,
        datacotacao,
        ativos.id_setor,
        ativos.ds_setor,
        valor_close_mes
    FROM movativos_mes_completo 
)

select * from final 
