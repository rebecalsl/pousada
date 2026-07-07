-- ============================================================================
-- TABELA: hospedes
-- DESCRIÇÃO: Armazena informações dos hóspedes da pousada
-- ============================================================================

CREATE TABLE IF NOT EXISTS hospedes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX idx_hospedes_email ON hospedes(email);
CREATE INDEX idx_hospedes_nome ON hospedes(nome);

-- Comentários da tabela
COMMENT ON TABLE hospedes IS 'Tabela que armazena dados dos hóspedes';
COMMENT ON COLUMN hospedes.id IS 'Identificador único do hóspede';
COMMENT ON COLUMN hospedes.nome IS 'Nome completo do hóspede';
COMMENT ON COLUMN hospedes.telefone IS 'Telefone de contato do hóspede';
COMMENT ON COLUMN hospedes.email IS 'Email de contato do hóspede';
COMMENT ON COLUMN hospedes.data_criacao IS 'Data de criação do registro';
