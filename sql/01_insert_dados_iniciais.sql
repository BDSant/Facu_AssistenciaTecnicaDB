-- 01_insert_dados_iniciais.sql
USE AssistenciaTecnicaDB;
GO

------------------------------------------------------------
-- CLIENTE
------------------------------------------------------------
INSERT INTO Cliente (Nome, CPF, Telefone, Email)
VALUES
('Maria Souza',      '11111111111', '(11) 99999-1111', 'maria.souza@example.com'),
('João Pereira',     '22222222222', '(11) 98888-2222', 'joao.pereira@example.com'),
('Ana Oliveira',     '33333333333', '(11) 97777-3333', 'ana.oliveira@example.com');
GO

------------------------------------------------------------
-- ATENDENTE
------------------------------------------------------------
INSERT INTO Atendente (Nome, Telefone, Email)
VALUES
('Carla Atendimento', '(11) 4000-1000', 'carla.atendimento@example.com'),
('Rafael Balcão',     '(11) 4000-2000', 'rafael.balcao@example.com');
GO

------------------------------------------------------------
-- TECNICO
------------------------------------------------------------
INSERT INTO Tecnico (Nome, Especialidade, Telefone, Email)
VALUES
('Carlos Técnico', 'Celulares', '(11) 5000-1000', 'carlos.tecnico@example.com'),
('Bruno Técnico',  'Notebooks', '(11) 5000-2000', 'bruno.tecnico@example.com');
GO

------------------------------------------------------------
-- APARELHO
-- (assumindo que os IdCliente gerados foram 1, 2 e 3)
------------------------------------------------------------
INSERT INTO Aparelho (IdCliente, TipoAparelho, Marca, Modelo, NumeroSerie, Observacoes)
VALUES
(1, 'Celular',  'Samsung', 'Galaxy A12',   'SN-SAM-A12-001', 'Tela trincada'),
(1, 'Notebook', 'Dell',    'Inspiron 15',  'SN-DEL-INS-001', 'Não liga'),
(2, 'Tablet',   'Apple',   'iPad 9ª Geração', 'SN-APL-IPD-001', 'Bateria descarrega rápido');
GO

------------------------------------------------------------
-- SERVICO (catálogo)
------------------------------------------------------------
INSERT INTO Servico (Descricao, ValorReferencia)
VALUES
('Troca de tela',         350.00),
('Troca de bateria',      250.00),
('Limpeza interna',       150.00),
('Formatação de sistema', 200.00);
GO

------------------------------------------------------------
-- ORDEM DE SERVIÇO
-- (assumindo: IdCliente 1,2 ; IdAparelho 1,2,3; IdAtendente 1,2; IdTecnico 1,2)
------------------------------------------------------------
INSERT INTO OrdemServico
    (IdCliente, IdAparelho, IdAtendente, IdTecnico,
     Status, DefeitoRelatado, DefeitoConstatado, PrazoEstimado)
VALUES
(1, 1, 1, 1,
 'Em Análise',
 'Celular caiu e quebrou a tela',
 NULL,
 DATEADD(DAY, 3, GETDATE())
),
(1, 2, 2, 2,
 'Aprovada',
 'Notebook não liga',
 'Problema na placa-mãe',
 DATEADD(DAY, 7, GETDATE())
),
(2, 3, 1, 1,
 'Aguardando Aprovação',
 'Tablet com bateria fraca',
 'Bateria com desgaste elevado',
 DATEADD(DAY, 5, GETDATE())
);
GO

------------------------------------------------------------
-- ORÇAMENTO (1 por OS)
-- assumindo que IdOS gerados foram 1, 2, 3
------------------------------------------------------------
INSERT INTO Orcamento (IdOS, ValorMaoDeObra, ValorPecas, ValorTotal, Situacao)
VALUES
(1, 150.00, 200.00, 350.00, 'Aguardando'),
(2, 300.00, 400.00, 700.00, 'Aprovado'),
(3, 120.00, 180.00, 300.00, 'Aguardando');
GO

------------------------------------------------------------
-- PAGAMENTO (pode ter mais de um por OS)
------------------------------------------------------------
-- OS 2 já foi paga em duas parcelas (sinal + restante)
INSERT INTO Pagamento (IdOS, DataPagamento, ValorPago, FormaPagamento, Observacoes)
VALUES
(2, GETDATE(),       200.00, 'PIX',    'Sinal'),
(2, DATEADD(DAY, 2, GETDATE()), 500.00, 'Cartao', 'Restante do pagamento');
GO

------------------------------------------------------------
-- OS_SERVICO (relação N:N OS x Servico)
------------------------------------------------------------
-- OS 1 - Troca de tela
INSERT INTO OS_Servico (IdOS, IdServico, Quantidade, ValorUnitario, ValorTotal)
VALUES
(1, 1, 1, 350.00, 350.00);

-- OS 2 - Limpeza interna + formatação
INSERT INTO OS_Servico (IdOS, IdServico, Quantidade, ValorUnitario, ValorTotal)
VALUES
(2, 3, 1, 150.00, 150.00),
(2, 4, 1, 200.00, 200.00);

-- OS 3 - Troca de bateria
INSERT INTO OS_Servico (IdOS, IdServico, Quantidade, ValorUnitario, ValorTotal)
VALUES
(3, 2, 1, 250.00, 250.00);
GO

------------------------------------------------------------
-- FOTO_OS (opcional, sem conteúdo binário real)
------------------------------------------------------------
INSERT INTO Foto_OS (IdOS, ConteudoFoto, Descricao)
VALUES
(1, NULL, 'Foto do aparelho antes do conserto'),
(1, NULL, 'Foto do aparelho depois do conserto');
GO
