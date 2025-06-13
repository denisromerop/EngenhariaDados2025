# Engenharia de dados - 2025-1
# RA - 24.85810-2 - DENIS ROMERO PEREIRA
# RA - 24.86064-5 - MARCELO BOTTER
# Containers
## dbt_compose e dbt

### Nosso container de postgresql
- app
    - postgresql
    - cliente simples

### Nosso container do dbt
- dbt
    - dbt-core
    - dbt-postgresl

# Estrutura de diretórios e arquivos
## Arquivos do app
- app
    - .env
    - Dockerfile
    - requirements.txt
    - script.py

## Arquivos do dbt
- dbt_compose
    - app
    - dbt
        - .dbt
            - profiles.yaml
    - Dockerfile

## Nossa receita docker compose
- Compose.yaml



