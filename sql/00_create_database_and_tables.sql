/* ============================================================
   00_create_database_and_tables.sql
   Mini-mundo: Assistência Técnica
   SQL Server
   ============================================================ */

------------------------------------------------------------
-- 1) Criação do Banco de Dados
------------------------------------------------------------
IF DB_ID('AssistenciaTecnicaDB') IS NULL
BEGIN
    CREATE DATABASE AssistenciaTecnicaDB;
END;
GO

USE AssistenciaTecnicaDB;
GO

------------------------------------------------------------
-- 2) Criação das Tabelas
-- Ordem: primeiro as "tabelas pai", depois as que têm FK
------------------------------------------------------------

------------------------------------------------------------
-- Tabela: CLIENTE
------------------------------------------------------------
CREATE TABLE Cliente (
    IdCliente    INT IDENTITY(1,1) CONSTRAINT PK_Cliente PRIMARY KEY,
    Nome         VARCHAR(150)  NOT NULL,
    CPF          CHAR(11)      NOT NULL CONSTRAINT UQ_Cliente_CPF UNIQUE,
    Telefone     VARCHAR(20)   NULL,
    Email        VARCHAR(150)  NULL,
    DataCadastro DATETIME      NOT NULL CONSTRAINT DF_Cliente_DataCadastro DEFAULT (GETDATE())
);
GO

------------------------------------------------------------
-- Tabela: ATENDENTE
------------------------------------------------------------
CREATE TABLE Atendente (
    IdAtendente INT IDENTITY(1,1) CONSTRAINT PK_Atendente PRIMARY KEY,
    Nome        VARCHAR(150) NOT NULL,
    Telefone    VARCHAR(20)  NULL,
    Email       VARCHAR(150) NULL
);
GO

------------------------------------------------------------
-- Tabela: TECNICO
------------------------------------------------------------
CREATE TABLE Tecnico (
    IdTecnico     INT IDENTITY(1,1) CONSTRAINT PK_Tecnico PRIMARY KEY,
    Nome          VARCHAR(150) NOT NULL,
    Especialidade VARCHAR(100) NULL,
    Telefone      VARCHAR(20)  NULL,
    Email         VARCHAR(150) NULL
);
GO

------------------------------------------------------------
-- Tabela: SERVICO (catálogo de serviços)
------------------------------------------------------------
CREATE TABLE Servico (
    IdServico       INT IDENTITY(1,1) CONSTRAINT PK_Servico PRIMARY KEY,
    Descricao       VARCHAR(150) NOT NULL,
    ValorReferencia DECIMAL(10,2) NULL
);
GO

------------------------------------------------------------
-- Tabela: APARELHO
-- Depende de CLIENTE
------------------------------------------------------------
CREATE TABLE Aparelho (
    IdAparelho   INT IDENTITY(1,1) CONSTRAINT PK_Aparelho PRIMARY KEY,
    IdCliente    INT          NOT NULL,
    TipoAparelho VARCHAR(50)  NOT NULL,  -- celular, notebook, tablet...
    Marca        VARCHAR(80)  NULL,
    Modelo       VARCHAR(80)  NULL,
    NumeroSerie  VARCHAR(80)  NULL,
    Observacoes  VARCHAR(500) NULL,

    CONSTRAINT FK_Aparelho_Cliente
        FOREIGN KEY (IdCliente) REFERENCES Cliente (IdCliente)
);
GO

------------------------------------------------------------
-- Tabela: ORDEM_SERVICO
-- Depende de CLIENTE, APARELHO, ATENDENTE e (opcional) TECNICO
------------------------------------------------------------
CREATE TABLE OrdemServico (
    IdOS              INT IDENTITY(1,1) CONSTRAINT PK_OrdemServico PRIMARY KEY,
    IdCliente         INT          NOT NULL,
    IdAparelho        INT          NOT NULL,
    IdAtendente       INT          NOT NULL,
    IdTecnico         INT              NULL,  -- pode ser definido depois
    DataAbertura      DATETIME     NOT NULL CONSTRAINT DF_OrdemServico_DataAbertura DEFAULT (GETDATE()),
    Status            VARCHAR(30)  NOT NULL,  -- Aberta, Em Análise, etc.
    DefeitoRelatado   VARCHAR(500) NOT NULL,
    DefeitoConstatado VARCHAR(500) NULL,
    PrazoEstimado     DATETIME     NULL,
    DataConclusao     DATETIME     NULL,

    CONSTRAINT FK_OrdemServico_Cliente
        FOREIGN KEY (IdCliente)   REFERENCES Cliente   (IdCliente),
    CONSTRAINT FK_OrdemServico_Aparelho
        FOREIGN KEY (IdAparelho)  REFERENCES Aparelho  (IdAparelho),
    CONSTRAINT FK_OrdemServico_Atendente
        FOREIGN KEY (IdAtendente) REFERENCES Atendente (IdAtendente),
    CONSTRAINT FK_OrdemServico_Tecnico
        FOREIGN KEY (IdTecnico)   REFERENCES Tecnico   (IdTecnico)
);
GO

------------------------------------------------------------
-- Tabela: ORCAMENTO
-- 1:1 com ORDEM_SERVICO
------------------------------------------------------------
CREATE TABLE Orcamento (
    IdOrcamento   INT IDENTITY(1,1) CONSTRAINT PK_Orcamento PRIMARY KEY,
    IdOS          INT          NOT NULL,
    DataOrcamento DATETIME     NOT NULL CONSTRAINT DF_Orcamento_Data DEFAULT (GETDATE()),
    ValorMaoDeObra DECIMAL(10,2) NOT NULL,
    ValorPecas     DECIMAL(10,2) NOT NULL,
    ValorTotal     DECIMAL(10,2) NOT NULL,
    Situacao       VARCHAR(20)  NOT NULL,   -- Aguardando, Aprovado, Recusado...

    CONSTRAINT FK_Orcamento_OrdemServico
        FOREIGN KEY (IdOS) REFERENCES OrdemServico (IdOS),
    -- Garante relação 1:1 com OrdemServico
    CONSTRAINT UQ_Orcamento_IdOS UNIQUE (IdOS)
);
GO

------------------------------------------------------------
-- Tabela: PAGAMENTO
-- N:1 com ORDEM_SERVICO
------------------------------------------------------------
CREATE TABLE Pagamento (
    IdPagamento   INT IDENTITY(1,1) CONSTRAINT PK_Pagamento PRIMARY KEY,
    IdOS          INT          NOT NULL,
    DataPagamento DATETIME     NOT NULL CONSTRAINT DF_Pagamento_Data DEFAULT (GETDATE()),
    ValorPago     DECIMAL(10,2) NOT NULL,
    FormaPagamento VARCHAR(20) NOT NULL,   -- Dinheiro, Cartao, PIX, etc.
    Observacoes   VARCHAR(300) NULL,

    CONSTRAINT FK_Pagamento_OrdemServico
        FOREIGN KEY (IdOS) REFERENCES OrdemServico (IdOS)
);
GO

------------------------------------------------------------
-- Tabela: OS_SERVICO
-- Tabela associativa N:N entre ORDEM_SERVICO e SERVICO
------------------------------------------------------------
CREATE TABLE OS_Servico (
    IdOS          INT          NOT NULL,
    IdServico     INT          NOT NULL,
    Quantidade    INT          NOT NULL CONSTRAINT DF_OS_Servico_Quantidade DEFAULT (1),
    ValorUnitario DECIMAL(10,2) NOT NULL,
    ValorTotal    DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_OS_Servico
        PRIMARY KEY (IdOS, IdServico),

    CONSTRAINT FK_OS_Servico_OrdemServico
        FOREIGN KEY (IdOS)     REFERENCES OrdemServico (IdOS),

    CONSTRAINT FK_OS_Servico_Servico
        FOREIGN KEY (IdServico) REFERENCES Servico (IdServico)
);
GO

------------------------------------------------------------
-- Tabela: FOTO_OS
-- Fotos associadas a uma Ordem de Serviço
------------------------------------------------------------
CREATE TABLE Foto_OS (
    IdFoto       INT IDENTITY(1,1) CONSTRAINT PK_Foto_OS PRIMARY KEY,
    IdOS         INT          NOT NULL,
    ConteudoFoto VARBINARY(MAX) NULL,   -- pode ser NULL se for usado apenas caminho
    Descricao    VARCHAR(200) NULL,
    DataCadastro DATETIME     NOT NULL CONSTRAINT DF_Foto_OS_DataCadastro DEFAULT (GETDATE()),

    CONSTRAINT FK_Foto_OS_OrdemServico
        FOREIGN KEY (IdOS) REFERENCES OrdemServico (IdOS)
);
GO
