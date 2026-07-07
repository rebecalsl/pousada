-- ============================================================================
-- TABELA: quartos
-- DESCRIÇÃO: Armazena informações dos quartos disponíveis na pousada
-- ============================================================================

CREATE TABLE IF NOT EXISTS quartos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    capacidade INT NOT NULL CHECK (capacidade > 0),
    preco_diaria DECIMAL(10, 2) NOT NULL CHECK (preco_diaria > 0),
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX idx_quartos_nome ON quartos(nome);
CREATE INDEX idx_quartos_ativo ON quartos(ativo);

-- Comentários da tabela
COMMENT ON TABLE quartos IS 'Tabela que armazena dados dos quartos da pousada';
COMMENT ON COLUMN quartos.id IS 'Identificador único do quarto';
COMMENT ON COLUMN quartos.nome IS 'Nome ou número do quarto';
COMMENT ON COLUMN quartos.descricao IS 'Descrição detalhada do quarto';
COMMENT ON COLUMN quartos.capacidade IS 'Número máximo de hóspedes';
COMMENT ON COLUMN quartos.preco_diaria IS 'Preço por noite';
COMMENT ON COLUMN quartos.ativo IS 'Indica se o quarto está disponível';
COMMENT ON COLUMN quartos.data_criacao IS 'Data de criação do registro';
