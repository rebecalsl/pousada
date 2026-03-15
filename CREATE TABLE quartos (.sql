CREATE TABLE quartos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    capacidade INT,
    preco_diaria DECIMAL(10,2)
);