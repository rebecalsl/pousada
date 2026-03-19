-- Tabela de ingredientes
CREATE TABLE ingredientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade DECIMAL(10,2) NOT NULL
);

-- Tabela de produtos (lanche ou marmita)
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Relação entre produtos e ingredientes
CREATE TABLE produto_ingrediente (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id) ON DELETE CASCADE,
    ingrediente_id INT REFERENCES ingredientes(id) ON DELETE CASCADE,
    quantidade_usada DECIMAL(10,2) NOT NULL
);