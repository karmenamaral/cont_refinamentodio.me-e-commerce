# cont_refinamentodio.me-e-commerce
Continuação do refinamento do E-commerce - desafio dio.me Heineken

# Desafio de Modelagem e SQL - E-commerce

Este projeto representa a modelagem e implementação de um banco de dados para um cenário de e-commerce, conforme desafio proposto.

## Estrutura do Modelo

- Clientes PF e PJ, com restrição para ser apenas um tipo
- Vendedores e Fornecedores
- Produtos, Estoque e Pedidos
- Pagamentos com múltiplas formas por pedido
- Entregas com código de rastreio e status

## Funcionalidades

- Consultas com filtros, expressões derivadas, ordenações e agrupamentos
- JOINs para visualização cruzada entre tabelas
- Queries respondendo perguntas de negócio, como:
  - Quem são os clientes que mais compram?
  - Quais produtos têm estoque baixo?
  - Quais fornecedores vendem mais?
  - Um vendedor também pode ser fornecedor?

## Execução

1. Crie o banco `ecommerce`
2. Execute o script `schema.sql` para criar as tabelas
3. Execute o script `insert.sql` para popular dados
4. Execute as queries em `queries.sql` para análise


