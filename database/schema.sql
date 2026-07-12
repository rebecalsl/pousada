CREATE TABLE hospedes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150) UNIQUE
);

CREATE TABLE quartos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    capacidade INT NOT NULL DEFAULT 1,
    preco_diaria DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'disponivel'
);

CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    hospede_id INT NOT NULL REFERENCES hospedes(id),
    quarto_id INT NOT NULL REFERENCES quartos(id),
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pendente',
    CONSTRAINT reservas_periodo_valido CHECK (data_checkout > data_checkin)
);

CREATE TABLE ingredientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade DECIMAL(10,2) NOT NULL
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE produto_ingrediente (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id) ON DELETE CASCADE,
    ingrediente_id INT REFERENCES ingredientes(id) ON DELETE CASCADE,
    quantidade_usada DECIMAL(10,2) NOT NULL
);
