/* ============================================================
   99_drop_tables_and_database.sql
   Mini-mundo: Assistência Técnica
   SQL Server
   ============================================================ */

------------------------------------------------------------
-- 1) Derrubar as tabelas na ordem correta
--    (primeiro as que possuem FKs, depois as "pais")
------------------------------------------------------------
IF DB_ID('AssistenciaTecnicaDB') IS NOT NULL
BEGIN
    USE AssistenciaTecnicaDB;
    PRINT 'Usando banco AssistenciaTecnicaDB...';

    -- Tabelas que dependem de ORDEM_SERVICO
    IF OBJECT_ID('dbo.Foto_OS', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Foto_OS;
        PRINT 'Tabela Foto_OS dropada.';
    END;

    IF OBJECT_ID('dbo.OS_Servico', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.OS_Servico;
        PRINT 'Tabela OS_Servico dropada.';
    END;

    IF OBJECT_ID('dbo.Pagamento', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Pagamento;
        PRINT 'Tabela Pagamento dropada.';
    END;

    IF OBJECT_ID('dbo.Orcamento', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Orcamento;
        PRINT 'Tabela Orcamento dropada.';
    END;

    -- Tabelas principais ligadas a várias FKs
    IF OBJECT_ID('dbo.OrdemServico', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.OrdemServico;
        PRINT 'Tabela OrdemServico dropada.';
    END;

    -- Tabelas dependentes de Cliente
    IF OBJECT_ID('dbo.Aparelho', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Aparelho;
        PRINT 'Tabela Aparelho dropada.';
    END;

    -- Catálogo de serviços
    IF OBJECT_ID('dbo.Servico', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Servico;
        PRINT 'Tabela Servico dropada.';
    END;

    -- Tabelas de pessoas
    IF OBJECT_ID('dbo.Tecnico', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Tecnico;
        PRINT 'Tabela Tecnico dropada.';
    END;

    IF OBJECT_ID('dbo.Atendente', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Atendente;
        PRINT 'Tabela Atendente dropada.';
    END;

    IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.Cliente;
        PRINT 'Tabela Cliente dropada.';
    END;
END;
GO

------------------------------------------------------------
-- 2) (Opcional) Remover completamente o banco de dados
------------------------------------------------------------
IF DB_ID('AssistenciaTecnicaDB') IS NOT NULL
BEGIN
    USE master;
    -- Força desconectar sessões ativas antes de dropar
    ALTER DATABASE AssistenciaTecnicaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AssistenciaTecnicaDB;
    PRINT 'Banco AssistenciaTecnicaDB dropado.';
END;
GO
