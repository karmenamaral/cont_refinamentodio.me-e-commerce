/* 
 * MARIA DO CARMO  @KARMENAMARAL_
 * -----------------------------------------------------
 * Criação do schema do banco de dados E-commerce
 * -----------------------------------------------------
 */

USE `Ecommerce`;

-- 1. Cliente
INSERT INTO Cliente (Primeironome, NomeDoMeio, Sobrenome, TipoCliente, CPF_CNPJ, DataDeNascimento, Telefone, Email)
VALUES 
  ('Carlos', 'A.', 'Silva', 'Físico', '12345678901', '1985-06-15', '11999998888', 'carlos.silva@email.com'),
  ('Ana', 'B.', 'Santos', 'Físico', '98765432100', '1990-07-22', '11888887777', 'ana.santos@email.com'),
  ('Pedro', 'C.', 'Oliveira', 'Físico', '45612378900', '1982-08-30', '11777776666', 'pedro.oliveira@email.com'),
  ('Juliana', 'D.', 'Costa', 'Físico', '32165498700', '1995-09-12', '11666665555', 'juliana.costa@email.com'),
  ('Fernanda', 'E.', 'Almeida', 'Físico', '78945612300', '1988-10-25', '11555554444', 'fernanda.almeida@email.com');

-- 2. EnderecoCliente
INSERT INTO EnderecoCliente (idCliente, Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP)
VALUES 
  (1, 'Rua das Flores', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01010-000'),
  (2, 'Avenida Paulista', '456', NULL, 'Bela Vista', 'São Paulo', 'SP', '01310-000'),
  (3, 'Rua dos Pinheiros', '789', 'Casa', 'Pinheiros', 'São Paulo', 'SP', '05410-000'),
  (4, 'Rua Augusta', '101', 'Apto 302', 'Consolação', 'São Paulo', 'SP', '01304-001'),
  (5, 'Avenida Ibirapuera', '202', NULL, 'Moema', 'São Paulo', 'SP', '04029-000');

-- 3. Cartao
INSERT INTO Cartao (idCliente, NomeTitular, NumeroCartao, Validade, CVV, Bandeira)
VALUES 
  (1, 'Carlos A. Silva', '4111111111111111', '12/27', '123', 'Visa'),
  (2, 'Ana B. Santos', '5500000000000004', '06/28', '456', 'Mastercard'),
  (3, 'Pedro C. Oliveira', '340000000000009', '09/26', '789', 'Amex'),
  (4, 'Juliana D. Costa', '6011000000000004', '03/29', '321', 'Elo'),
  (5, 'Fernanda E. Almeida', '3530111333300000', '11/25', '654', 'Outro');

-- 4. Pedido
INSERT INTO Pedido (idCliente, StatusPedido, Frete, DescPedido, DataPedido)
VALUES 
  (1, 'Em andamento', 20.00, 'Pedido de Eletrônicos', NOW()),
  (2, 'Processando', 15.00, 'Pedido de Moda', NOW()),
  (3, 'Enviado', 25.00, 'Pedido de Livros', NOW()),
  (4, 'Entregue', 10.00, 'Pedido de Brinquedos', NOW()),
  (5, 'Processando', 30.00, 'Pedido de Móveis', NOW());

-- 5. Pagamento
INSERT INTO Pagamento (idPedido, idCartao, Valor, FormaPagamento, DataPagamento)
VALUES 
  (1, 1, 220.00, 'Cartao', NOW()),
  (2, 2, 115.00, 'Pix', NOW()),
  (3, 3, 325.00, 'Boleto', NOW()),
  (4, 4, 110.00, 'Transferencia', NOW()),
  (5, 5, 530.00, 'Dinheiro', NOW());

-- 6. Entrega
INSERT INTO Entrega (idEntrega, idPedido, StatusEntrega, CodigoRastreio, DataEnvio, DataEntrega)
VALUES 
  (1, 1, 'A caminho', 'BR123456789', '2025-04-01', NULL),
  (2, 2, 'Preparando envio', 'BR987654321', '2025-04-02', NULL),
  (3, 3, 'Entregue', 'BR456123789', '2025-03-30', '2025-04-03'),
  (4, 4, 'Entregue', 'BR321654987', '2025-03-28', '2025-04-02'),
  (5, 5, 'Aguardando coleta', 'BR789456123', NULL, NULL);

-- 7. Categoria
INSERT INTO CategoriaProduto (Categoria)
VALUES 
  ('Eletrônicos'),
  ('Moda'),
  ('Livros'),
  ('Móveis'),
  ('Acessórios');

-- 8. Produto
INSERT INTO Produto (PNome, Classificacao_kids, idCategoria, Descricao, Valor, Avaliacao)
VALUES 
  ('Notebook', '0', 1, 'Notebook Dell Inspiron', 3500.00, 8.0),
  ('Smartphone', '0', 1, 'iPhone 14 Pro Max', 7500.00, 9.0),
  ('Livro', '1', 3, 'Clean Code - Robert C. Martin', 150.00, 10.0),
  ('Cadeira Gamer', '1', 4, 'Cadeira ergonômica para escritório', 800.00, 10.0),
  ('Fone de Ouvido', '1', 1, 'Fone Bluetooth com cancelamento de ruído', 500.00, 0.60);

-- 9. ItemPedido
ALTER TABLE ItemPedido
  CHANGE COLUMN Status StatusEstoque ENUM('Disponivel', 'Sem Estoque') NOT NULL DEFAULT 'Sem Estoque';

INSERT INTO ItemPedido (idPedido, idProduto, Quantidade, ValorUnitario, StatusEstoque)
VALUES 
  (1, 1, 1, 3500.00, 'Disponivel'),
  (2, 2, 1, 7500.00, 'Disponivel'),
  (3, 3, 2, 150.00, 'Disponivel'),
  (4, 4, 1, 800.00, 'Disponivel'),
  (5, 5, 3, 500.00, 'Sem Estoque'),
  (2, 3, 1, 3500.00, 'Disponivel'),
  (2, 4, 3, 7500.00, 'Disponivel');

-- 10. Fornecedor
INSERT INTO Fornecedor (NomeSocial, CNPJ, Telefone, Email)
VALUES 
  ('Tech Supplies', '12345678000199', '1133332222', 'contato@techsupplies.com'),
  ('Moda Fashion', '98765432000188', '1144443333', 'suporte@modafashion.com');

-- 11. FornecedorProduto
INSERT INTO FornecedorProduto (idFornecedor, idProduto)
VALUES 
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (2, 5);

-- 12. Estoque
INSERT INTO Estoque (idProduto, Quantidade, LocalEstoque)
VALUES 
  (1, 50, 'Galpão A'),
  (2, 30, 'Galpão B'),
  (3, 100, 'Galpão C'),
  (4, 20, 'Galpão A'),
  (5, 40, 'Galpão B');

-- 13. AvaliacaoProduto
INSERT INTO AvaliacaoProduto (idProduto, idCliente, Nota, Comentario)
VALUES 
  (1, 1, 5, 'Ótimo notebook!'),
  (2, 2, 4, 'Bom celular, mas caro.'),
  (3, 3, 5, 'Livro excelente!'),
  (4, 4, 3, 'Confortável, mas difícil de montar.'),
  (5, 5, 4, 'Ótima qualidade de som.');

-- 14. Devolucao
ALTER TABLE Devolucao
  CHANGE COLUMN DataDevolucao DataDevolucao DATETIME;

INSERT INTO Devolucao (idPedido, idProduto, Motivo, DataDevolucao)
VALUES 
  (3, 3, 'Produto danificado', NOW()),
  (2, 2, 'Produto danificado', NOW());

-- 15. Vendedor
INSERT INTO Vendedor (idVendedor, RazaoSocial, Local, TipoVendedor, CPF_CNPJ, NomeFantasia, Telefone)
VALUES 
  (1, 'Mercado Livre LTDA', 'São Paulo - SP', 'Jurídico', '12345678000199', 'Mercado Livre', '11999990000'),
  (2, 'Amazon Brasil LTDA', 'Cajamar - SP', 'Jurídico', '98765432000188', 'Amazon', '11888887777'),
  (3, 'Tio da esquina', 'São Paulo - SP', 'Jurídico', '15346678000199', 'Mercado Livre', '11999990000');

-- 16. ProdutosVendedor
INSERT INTO ProdutosVendedor (IdProduto, IdVendedor, PQuantidade)
VALUES 
  (1, 1, 10),   -- Notebook vendido pelo Mercado Livre
  (2, 1, 15),   -- Smartphone vendido pelo Mercado Livre
  (3, 2, 20),   -- Livro vendido pela Amazon
  (4, 2, 5),    -- Cadeira Gamer vendida pela Amazon
  (5, 3, 30);   -- Fone de Ouvido vendido pelo Tio da esquina
