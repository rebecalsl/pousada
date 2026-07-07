-- ============================================================================
-- DADOS INICIAIS (SEEDS)
-- DESCRIÇÃO: Dados de exemplo para teste e desenvolvimento
-- ============================================================================

-- Inserir hóspedes de exemplo
INSERT INTO hospedes (nome, telefone, email) VALUES
('João Silva', '11999999999', 'joao@email.com'),
('Maria Santos', '11988888888', 'maria@email.com'),
('Pedro Oliveira', '11977777777', 'pedro@email.com')
ON CONFLICT DO NOTHING;

-- Inserir quartos de exemplo
INSERT INTO quartos (nome, descricao, capacidade, preco_diaria) VALUES
('Quarto 101', 'Quarto padrão com cama de casal', 2, 150.00),
('Quarto 102', 'Quarto deluxe com vista para o mar', 2, 250.00),
('Quarto 201', 'Suíte com sala e cozineta', 4, 400.00)
ON CONFLICT DO NOTHING;

-- Inserir ingredientes de exemplo
INSERT INTO ingredientes (nome, preco, quantidade, unidade) VALUES
('Pão francês', 5.00, 100, 'un'),
('Queijo meia cura', 40.00, 10, 'kg'),
('Presunto', 35.00, 5, 'kg'),
('Tomate', 3.00, 20, 'kg'),
('Alface', 4.00, 15, 'kg')
ON CONFLICT DO NOTHING;

-- Inserir produtos de exemplo
INSERT INTO produtos (nome, descricao, preco_venda) VALUES
('Marmita Simples', 'Marmita com arroz, feijão e frango', 25.00),
('Marmita Premium', 'Marmita deluxe com proteína de qualidade', 45.00),
('Lanche na Chapa', 'Pão, queijo e presunto na chapa', 15.00')
ON CONFLICT DO NOTHING;

-- Inserir relações produto-ingrediente
INSERT INTO produto_ingrediente (produto_id, ingrediente_id, quantidade_usada) VALUES
(1, 1, 0.5),
(1, 2, 0.1),
(1, 3, 0.1),
(3, 1, 1),
(3, 2, 0.05),
(3, 3, 0.05)
ON CONFLICT DO NOTHING;

-- Inserir reservas de exemplo
INSERT INTO reservas (hospede_id, quarto_id, data_checkin, data_checkout, status) VALUES
(1, 1, '2026-07-10', '2026-07-15', 'confirmada'),
(2, 2, '2026-07-20', '2026-07-25', 'pendente'),
(3, 3, '2026-08-01', '2026-08-05', 'confirmada')
ON CONFLICT DO NOTHING;
