-- ============================================================================
-- TABELA: produto_ingrediente
-- DESCRIÇÃO: Relação muitos-para-muitos entre produtos e ingredientes
-- ============================================================================

CREATE TABLE IF NOT EXISTS produto_ingrediente (
    id SERIAL PRIMARY KEY,
    produto_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    quantidade_usada DECIMAL(10, 2) NOT NULL CHECK (quantidade_usada > 0),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Restrições de chave estrangeira
    CONSTRAINT fk_pi_produto 
        FOREIGN KEY (produto_id) 
        REFERENCES produtos(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_pi_ingrediente 
        FOREIGN KEY (ingrediente_id) 
        REFERENCES ingredientes(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Chave única para evitar duplicatas
    UNIQUE(produto_id, ingrediente_id)
);

-- Índices para melhor performance
CREATE INDEX idx_pi_produto ON produto_ingrediente(produto_id);
CREATE INDEX idx_pi_ingrediente ON produto_ingrediente(ingrediente_id);

-- Comentários da tabela
COMMENT ON TABLE produto_ingrediente IS 'Tabela de junção que relaciona produtos e ingredientes';
COMMENT ON COLUMN produto_ingrediente.id IS 'Identificador único';
COMMENT ON COLUMN produto_ingrediente.produto_id IS 'Referência ao produto';
COMMENT ON COLUMN produto_ingrediente.ingrediente_id IS 'Referência ao ingrediente';
COMMENT ON COLUMN produto_ingrediente.quantidade_usada IS 'Quantidade do ingrediente usado no produto';
COMMENT ON COLUMN produto_ingrediente.data_criacao IS 'Data de criação do registro';
