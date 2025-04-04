/* 
 * MARIA DO CARMO  @KARMENAMARAL_
 * -----------------------------------------------------
 * Criação do schema do banco de dados E-commerce
 * -----------------------------------------------------
 */

DROP SCHEMA IF EXISTS `Ecommerce`;
CREATE SCHEMA IF NOT EXISTS `Ecommerce`;
USE `Ecommerce`;

-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cliente`;
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Primeironome` VARCHAR(10) NOT NULL, 
  `NomeDoMeio` VARCHAR(10),
  `Sobrenome` VARCHAR(20),
  `TipoCliente` ENUM('Físico', 'Jurídico') NOT NULL,
  `CPF_CNPJ` VARCHAR(14) NOT NULL,
  CONSTRAINT unique_cpf_cnpj_cliente UNIQUE (`CPF_CNPJ`),
  `DataDeNascimento` DATE NOT NULL,
  `Telefone` VARCHAR(15) NOT NULL, 
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCliente`)
);

-- -----------------------------------------------------
-- Table `EnderecoCliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EnderecoCliente`;
CREATE TABLE `EnderecoCliente` (
  `idEnderecoCliente` INT AUTO_INCREMENT PRIMARY KEY,
  `idCliente` INT NOT NULL,
  `Logradouro` VARCHAR(100) NOT NULL,
  `Numero` VARCHAR(10) NOT NULL,
  `Complemento` VARCHAR(50),
  `Bairro` VARCHAR(50) NOT NULL,
  `Cidade` VARCHAR(50) NOT NULL,
  `Estado` VARCHAR(2) NOT NULL,
  `CEP` VARCHAR(9) NOT NULL,
  FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Cartao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cartao`;
CREATE TABLE `Cartao` (
  `idCartao` INT AUTO_INCREMENT PRIMARY KEY,
  `idCliente` INT NOT NULL,
  `NomeTitular` VARCHAR(100) NOT NULL,
  `NumeroCartao` VARCHAR(16) NOT NULL,
  `Validade` VARCHAR(7) NOT NULL,
  `CVV` VARCHAR(4) NOT NULL,
  `Bandeira` ENUM('Visa', 'Mastercard', 'Elo', 'Amex', 'Outro') NOT NULL,
  FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pedido`;
CREATE TABLE `Pedido` (
  `idPedido` INT AUTO_INCREMENT PRIMARY KEY,
  `idCliente` INT NOT NULL,
  `StatusPedido` ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Processando',
  `Frete` DECIMAL(10,2) DEFAULT 0,
  `DescPedido` VARCHAR(50) NOT NULL,
  `DataPedido` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pagamento`;
CREATE TABLE `Pagamento` (
  `idPagamento` INT AUTO_INCREMENT PRIMARY KEY,
  `idPedido` INT NOT NULL,
  `idCartao` INT,
  `Valor` DECIMAL(10,2) NOT NULL,
  `FormaPagamento` ENUM('Boleto', 'Cartao', 'Pix', 'Transferencia','Dinheiro') NOT NULL DEFAULT 'Dinheiro',
  `DataPagamento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`idPedido`) REFERENCES `Pedido` (`idPedido`) ON DELETE CASCADE,
  FOREIGN KEY (`idCartao`) REFERENCES `Cartao` (`idCartao`) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Table `Entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Entrega`;
CREATE TABLE `Entrega` (
  `idEntrega` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `StatusEntrega` VARCHAR(45),
  `CodigoRastreio` VARCHAR(45),
  `DataEnvio` DATE,
  `DataEntrega` DATE,
  PRIMARY KEY (`idEntrega`, `idPedido`)
);

-- -----------------------------------------------------
-- Table `CategoriaProduto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CategoriaProduto`;
CREATE TABLE `CategoriaProduto` (
  `idCategoria` INT AUTO_INCREMENT PRIMARY KEY,
  `Categoria` VARCHAR(50) NOT NULL
);

-- -----------------------------------------------------
-- Table `Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Produto`;
CREATE TABLE `Produto` (
  `idProduto` INT AUTO_INCREMENT PRIMARY KEY,
  `PNome` VARCHAR(100) NOT NULL,
  `Classificacao_kids` BOOLEAN DEFAULT FALSE,
  `idCategoria` INT NOT NULL,
  `Descricao` TEXT,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Avaliacao` FLOAT DEFAULT 0,
  FOREIGN KEY (`idCategoria`) REFERENCES `CategoriaProduto` (`idCategoria`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `ItemPedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ItemPedido`;
CREATE TABLE `ItemPedido` (
  `idProduto` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  `ValorUnitario` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `Status` ENUM('Disponivel', 'Sem Estoque') NOT NULL DEFAULT 'Sem Estoque',
  PRIMARY KEY (`idProduto`, `idPedido`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`) ON DELETE CASCADE,
  FOREIGN KEY (`idPedido`) REFERENCES `Pedido` (`idPedido`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Fornecedor`;
CREATE TABLE `Fornecedor` (
  `idFornecedor` INT AUTO_INCREMENT PRIMARY KEY,
  `NomeSocial` VARCHAR(255) NOT NULL,
  `CNPJ` VARCHAR(18) NOT NULL,
  CONSTRAINT unique_cpf_cnpj_Fornecedor UNIQUE (`CNPJ`),
  `Telefone` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `FornecedorProduto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FornecedorProduto`;
CREATE TABLE `FornecedorProduto` (
  `idProduto` INT NOT NULL,
  `idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `idFornecedor`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`) ON DELETE CASCADE,
  FOREIGN KEY (`idFornecedor`) REFERENCES `Fornecedor` (`idFornecedor`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Estoque`;
CREATE TABLE `Estoque` (
  `idEstoque` INT AUTO_INCREMENT PRIMARY KEY,
  `idProduto` INT NOT NULL,
  `LocalEstoque` VARCHAR(100) NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `AvaliacaoProduto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AvaliacaoProduto`;
CREATE TABLE `AvaliacaoProduto` (
  `idAvaliacaoProduto` INT AUTO_INCREMENT PRIMARY KEY,
  `idProduto` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `Nota` INT NOT NULL,
  `Comentario` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`) ON DELETE CASCADE,
  FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Devolucao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Devolucao`;
CREATE TABLE `Devolucao` (
  `idDevolucao` INT AUTO_INCREMENT PRIMARY KEY,
  `idPedido` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `Motivo` VARCHAR(100) NOT NULL, 
  `DataDevolucao` DATE NOT NULL,
  FOREIGN KEY (`idPedido`) REFERENCES `Pedido` (`idPedido`) ON DELETE CASCADE,
  FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`idProduto`) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table `Vendedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vendedor`;
CREATE TABLE IF NOT EXISTS `Vendedor` (
  `idVendedor` INT NOT NULL,
  `RazaoSocial` VARCHAR(255),
  `Local` VARCHAR(45),
  `TipoVendedor` ENUM('Físico', 'Jurídico') NOT NULL,
  `CPF_CNPJ` VARCHAR(18) NOT NULL,
  `NomeFantasia` VARCHAR(100),
  `Telefone` VARCHAR(15),
  PRIMARY KEY (`idVendedor`)
);
CREATE UNIQUE INDEX `CPF_CNPJ_UNIQUE` ON `Vendedor` (`CPF_CNPJ`);

-- -----------------------------------------------------
-- Table `ProdutosVendedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProdutosVendedor`;
CREATE TABLE IF NOT EXISTS `ProdutosVendedor` (
  `IdProduto` INT NOT NULL,
  `IdVendedor` INT NOT NULL,
  `PQuantidade` INT,
  PRIMARY KEY (`IdProduto`, `IdVendedor`)
);

-- -----------------------------------------------------
-- Índices adicionais
-- -----------------------------------------------------
CREATE INDEX idx_idCliente ON `Pedido`(`idCliente`);
CREATE INDEX idx_idProduto ON `ItemPedido`(`idProduto`);
