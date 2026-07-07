-- ============================================================================
-- TABELA: ingredientes
-- DESCRIÇÃO: Armazena o catálogo de ingredientes disponíveis
-- ============================================================================

CREATE TABLE IF NOT EXISTS ingredientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco > 0),
    quantidade DECIMAL(10, 2) NOT NULL CHECK (quantidade >= 0),
    unidade VARCHAR(20) DEFAULT 'un',
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX idx_ingredientes_nome ON ingredientes(nome);
CREATE INDEX idx_ingredientes_ativo ON ingredientes(ativo);

-- Comentários da tabela
COMMENT ON TABLE ingredientes IS 'Tabela que armazena os ingredientes disponíveis';
COMMENT ON COLUMN ingredientes.id IS 'Identificador único do ingrediente';
COMMENT ON COLUMN ingredientes.nome IS 'Nome do ingrediente';
COMMENT ON COLUMN ingredientes.preco IS 'Preço unitário do ingrediente';
COMMENT ON COLUMN ingredientes.quantidade IS 'Quantidade em estoque';
COMMENT ON COLUMN ingredientes.unidade IS 'Unidade de medida (un, kg, l, etc)';
COMMENT ON COLUMN ingredientes.ativo IS 'Indica se o ingrediente está disponível';
COMMENT ON COLUMN ingredientes.data_criacao IS 'Data de criação do registro';
COMMENT ON COLUMN ingredientes.data_atualizacao IS 'Data da última atualização';
