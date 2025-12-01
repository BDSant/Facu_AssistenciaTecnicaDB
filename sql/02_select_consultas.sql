-- 02_select_consultas.sql
USE AssistenciaTecnicaDB;
GO

------------------------------------------------------------
-- 1) Listar todas as ordens de serviço com cliente e aparelho
------------------------------------------------------------
SELECT
    os.IdOS,
    c.Nome       AS NomeCliente,
    a.TipoAparelho,
    a.Marca,
    a.Modelo,
    os.Status,
    os.DataAbertura
FROM OrdemServico AS os
INNER JOIN Cliente  AS c ON os.IdCliente  = c.IdCliente
INNER JOIN Aparelho AS a ON os.IdAparelho = a.IdAparelho
ORDER BY os.DataAbertura DESC;
GO

------------------------------------------------------------
-- 2) TOP 5 clientes com maior número de ordens de serviço
------------------------------------------------------------
SELECT TOP 5
    c.IdCliente,
    c.Nome,
    COUNT(os.IdOS) AS QuantidadeOS
FROM Cliente AS c
LEFT JOIN OrdemServico AS os ON os.IdCliente = c.IdCliente
GROUP BY c.IdCliente, c.Nome
ORDER BY QuantidadeOS DESC;
GO

------------------------------------------------------------
-- 3) Ordens de serviço aprovadas com valor de orçamento
------------------------------------------------------------
SELECT
    os.IdOS,
    c.Nome AS Cliente,
    os.Status,
    o.ValorTotal
FROM OrdemServico AS os
INNER JOIN Orcamento AS o ON o.IdOS = os.IdOS
INNER JOIN Cliente   AS c ON c.IdCliente = os.IdCliente
WHERE o.Situacao = 'Aprovado'
ORDER BY o.ValorTotal DESC;
GO

------------------------------------------------------------
-- 4) Serviços executados por OS, com técnico responsável
------------------------------------------------------------
SELECT
    os.IdOS,
    t.Nome      AS Tecnico,
    s.Descricao AS Servico,
    oss.Quantidade,
    oss.ValorUnitario,
    oss.ValorTotal
FROM OS_Servico AS oss
INNER JOIN OrdemServico AS os ON os.IdOS       = oss.IdOS
INNER JOIN Servico      AS s  ON s.IdServico   = oss.IdServico
INNER JOIN Tecnico      AS t  ON t.IdTecnico   = os.IdTecnico
ORDER BY os.IdOS, s.Descricao;
GO
