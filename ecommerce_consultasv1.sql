/* 
 * MARIA DO CARMO  @KARMENAMARAL_
 * -----------------------------------------------------
 * Criação do schema do banco de dados E-commerce
 * -----------------------------------------------------
 */
USE ecommerce;

-- ================================================
-- 1. Produtos mais vendidos (por quantidade total vendida)
-- ================================================
-- Agrupa os itens vendidos por produto
-- Soma a quantidade vendida
-- Ordena do mais vendido para o menos

SELECT 
    p.Descricao,
    SUM(ip.Quantidade) AS TotalVendido
	FROM ItemPedido ip
INNER JOIN 
    Produto p ON ip.idProduto = p.idProduto
GROUP BY  p.Descricao
ORDER BY TotalVendido DESC;

-- ================================================
-- 2. Clientes que mais gastaram (acima de R$500)
-- ================================================
-- Agrupa por cliente
-- Soma o valor total de todos os pedidos do cliente
-- Usa HAVING para filtrar quem gastou mais de R$ 500
-- Ordena do que mais gastou para o que menos gastou

 SELECT CONCAT(c.PrimeiroNome, ' ', c.NomeDoMeio, ' ', c.Sobrenome) AS NomeCompleto, 
		SUM(ip.ValorUnitario * ip.Quantidade) AS TotalGasto
	FROM Pedido p
INNER JOIN Cliente c ON p.idCliente = c.idCliente
INNER JOIN ItemPedido ip ON p.idPedido = ip.idPedido
GROUP BY CONCAT(c.PrimeiroNome, ' ', c.NomeDoMeio, ' ', c.Sobrenome)
HAVING SUM(ip.ValorUnitario * ip.Quantidade) > 500
ORDER BY TotalGasto DESC;

-- ================================================
-- 3. Conferência: todos os itens de pedido
-- ================================================
SELECT * FROM ItemPedido;

-- ================================================
-- 4. Dias com mais vendas (pelo número de pedidos)
-- ================================================
-- Agrupa os pedidos por data
-- Conta quantos pedidos ocorreram por dia
-- Mostra apenas dias com pelo menos 2 pedidos

SELECT DATE(DataPedido) AS Dia,
    COUNT(*) AS TotalPedidos
	FROM Pedido
GROUP BY Dia
HAVING COUNT(*) >= 2
ORDER BY TotalPedidos DESC;

-- ================================================
-- 5. Produtos com estoque baixo (quantidade ≤ 30)
-- ================================================
-- Mostra produtos com estoque igual ou inferior a 30
-- Ordena do menor para o maior estoque

 SELECT p.Descricao,
	   e.Quantidade AS `Quantidade Estoque`
	FROM  Produto p
INNER JOIN  Estoque e ON p.idProduto = e.idProduto
WHERE e.Quantidade <= 30
ORDER BY e.Quantidade ASC;

-- ================================================
-- 6. Dados do pedido
-- ================================================
-- Mostra detalhes dos pedidos de um cliente
-- 

SELECT prod.*,
    c.Primeironome, c.Sobrenome, p.idPedido, p.DescPedido, p.StatusPedido, pa.FormaPagamento, v.RazaoSocial AS Vendedor 
FROM Pedido p
JOIN Cliente c ON p.idCliente = c.idCliente
JOIN Pagamento pa ON p.idPedido = pa.idPedido
JOIN ItemPedido ip ON p.idPedido = ip.idPedido
inner join produto prod on ip.idproduto = prod.idproduto
JOIN ProdutosVendedor pv ON ip.idProduto = pv.IdProduto
JOIN Vendedor v ON pv.IdVendedor = v.idVendedor
WHERE c.idCliente = 1;
-- ================================================
-- 7. Dados do pedido e mostra devoluções
-- ================================================
-- Mostra detalhes dos pedidos de todos os cliente
-- PEDIDOS COM DEVOLUÇÃO E SEM DEVOLUÇÃO
-- 
 SELECT c.Primeironome, 
		c.Sobrenome, 
        p.idPedido, 
        p.DescPedido, 
        p.StatusPedido,
        prod.*,
        d.*, 
        pa.FormaPagamento, 
        v.RazaoSocial AS Vendedor 
FROM Pedido p
INNER JOIN Cliente c ON p.idCliente = c.idCliente
INNER JOIN Pagamento pa ON p.idPedido = pa.idPedido
INNER JOIN ItemPedido ip ON p.idPedido = ip.idPedido
INNER join produto prod on ip.idproduto = prod.idproduto
INNER JOIN ProdutosVendedor pv ON ip.idProduto = pv.IdProduto
INNER JOIN Vendedor v ON pv.IdVendedor = v.idVendedor
LEFT JOIN Devolucao d on d.idpedido= p.idpedido
and d.idproduto= ip.idproduto;


-- ================================================
-- 8. Vendedor e produto
-- ================================================
-- Mostra produtos de cada vendedor

select v.*,p.PNome from ProdutosVendedor pv 
JOIN Vendedor v ON pv.IdVendedor = v.idVendedor
JOIN PRODUTO P ON P.IDPRODUTO =PV.IDPRODUTO
order by pv.PQuantidade;


