# Mini-mundo – Assistência Técnica  
## Scripts SQL – Projeto de Banco de Dados (SQL Server)

Este repositório contém os scripts SQL do projeto de banco de dados para o minimundo de **Assistência Técnica de Equipamentos Eletrônicos**, desenvolvidos como parte da Etapa 4 da disciplina.

O foco é mostrar a aplicação prática do modelo lógico anteriormente construído, utilizando **SQL Server** (SQL Server Management Studio – SSMS) para criação e manipulação dos dados.

---

## 🧱 1. Tecnologias Utilizadas

- **SGBD**: Microsoft SQL Server  
- **Ferramenta de administração**: SQL Server Management Studio (SSMS)  
- **Linguagem**: SQL (DDL e DML)

*** Obs.: O enunciado cita Workbench/PGAdmin, mas neste projeto foi utilizado **SQL Server + SSMS**, que atende ao mesmo objetivo de criação e teste de scripts SQL.

---

## 🗂 2. Estrutura do Repositório

```text
/
├── README.md
└── sql
    ├── 00_create_database_and_tables.sql   (Cria Banco de dados e tabelas)
    ├── 01_insert_dados_iniciais.sql
    ├── 02_select_consultas.sql
    ├── 03_updates_deletes.sql
    └── 99_drop_tables_and_database.sql     (Dropa tabelas e banco de dados)

