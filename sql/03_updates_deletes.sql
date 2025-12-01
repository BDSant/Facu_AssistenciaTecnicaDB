-- 03_updates_deletes.sql
USE AssistenciaTecnicaDB;
GO

/* ============================================================
   UPDATES (3 exemplos ou mais)
   ============================================================ */

------------------------------------------------------------
-- 1) Atualizar telefone de um cliente
------------------------------------------------------------
UPDATE Cliente
SET Telefone = '(11) 97777-0000'
WHERE CPF = '11111111111';
GO

------------------------------------------------------------
-- 2) Atualizar status de uma OS para 'Concluída'
--    (por exemplo, a OS 2 foi finalizada)
------------------------------------------------------------
UPDATE OrdemServico
SET Status = 'Concluída',
    DataConclusao = GETDATE()
WHERE IdOS = 2;
GO

------------------------------------------------------------
-- 3) Atualizar valor unitário de um serviço específico em uma OS
------------------------------------------------------------
UPDATE OS_Servico
SET ValorUnitario = 260.00,
    ValorTotal    = Quantidade * 260.00
WHERE IdOS = 3
  AND IdServico = 2;   -- Troca de bateria
GO

/* ============================================================
   DELETES (3 exemplos ou mais)
   Atenção à ordem para respeitar as FKs:
   primeiro tabelas filhas, depois a "pai".
   ============================================================ */

------------------------------------------------------------
-- 4) Excluir fotos de teste ligadas à OS 3 (se existirem)
------------------------------------------------------------
DELETE FROM Foto_OS
WHERE IdOS = 3;
GO

------------------------------------------------------------
-- 5) Excluir serviços vinculados à OS 3
------------------------------------------------------------
DELETE FROM OS_Servico
WHERE IdOS = 3;
GO

------------------------------------------------------------
-- 6) Excluir pagamentos e orçamento da OS 3 (se existirem)
------------------------------------------------------------
DELETE FROM Pagamento
WHERE IdOS = 3;
GO

DELETE FROM Orcamento
WHERE IdOS = 3;
GO

------------------------------------------------------------
-- 7) Finalmente, excluir a própria Ordem de Serviço 3
------------------------------------------------------------
DELETE FROM OrdemServico
WHERE IdOS = 3;
GO
