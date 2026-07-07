-- ============================================================================
-- TABELA: produtos
-- DESCRIÇÃO: Armazena os produtos (lanches, marmitas, etc) oferecidos
-- ============================================================================

CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    preco_venda DECIMAL(10, 2) NOT NULL CHECK (preco_venda > 0),
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX idx_produtos_nome ON produtos(nome);
CREATE INDEX idx_produtos_ativo ON produtos(ativo);

-- Comentários da tabela
COMMENT ON TABLE produtos IS 'Tabela que armazena os produtos oferecidos';
COMMENT ON COLUMN produtos.id IS 'Identificador único do produto';
COMMENT ON COLUMN produtos.nome IS 'Nome do produto';
COMMENT ON COLUMN produtos.descricao IS 'Descrição detalhada do produto';
COMMENT ON COLUMN produtos.preco_venda IS 'Preço de venda do produto';
COMMENT ON COLUMN produtos.ativo IS 'Indica se o produto está disponível';
COMMENT ON COLUMN produtos.data_criacao IS 'Data de criação do registro';
COMMENT ON COLUMN produtos.data_atualizacao IS 'Data da última atualização';
