-- ============================================================================
-- TABELA: reservas
-- DESCRIÇÃO: Armazena as reservas de quartos da pousada
-- ============================================================================

CREATE TABLE IF NOT EXISTS reservas (
    id SERIAL PRIMARY KEY,
    hospede_id INT NOT NULL,
    quarto_id INT NOT NULL,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'pendente' CHECK (status IN ('pendente', 'confirmada', 'cancelada', 'concluida')),
    observacoes TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Restrições de chave estrangeira
    CONSTRAINT fk_reservas_hospede 
        FOREIGN KEY (hospede_id) 
        REFERENCES hospedes(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_reservas_quarto 
        FOREIGN KEY (quarto_id) 
        REFERENCES quartos(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Validação de datas
    CONSTRAINT check_datas 
        CHECK (data_checkout > data_checkin)
);

-- Índices para melhor performance
CREATE INDEX idx_reservas_hospede ON reservas(hospede_id);
CREATE INDEX idx_reservas_quarto ON reservas(quarto_id);
CREATE INDEX idx_reservas_status ON reservas(status);
CREATE INDEX idx_reservas_datas ON reservas(data_checkin, data_checkout);

-- Comentários da tabela
COMMENT ON TABLE reservas IS 'Tabela que armazena as reservas de quartos';
COMMENT ON COLUMN reservas.id IS 'Identificador único da reserva';
COMMENT ON COLUMN reservas.hospede_id IS 'Referência ao hóspede que fez a reserva';
COMMENT ON COLUMN reservas.quarto_id IS 'Referência ao quarto reservado';
COMMENT ON COLUMN reservas.data_checkin IS 'Data de entrada do hóspede';
COMMENT ON COLUMN reservas.data_checkout IS 'Data de saída do hóspede';
COMMENT ON COLUMN reservas.status IS 'Status atual da reserva';
COMMENT ON COLUMN reservas.observacoes IS 'Observações adicionais sobre a reserva';
COMMENT ON COLUMN reservas.data_criacao IS 'Data de criação do registro';
