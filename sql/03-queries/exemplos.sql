-- ============================================================================
-- QUERIES DE EXEMPLO
-- DESCRIÇÃO: Exemplos de queries úteis para o sistema de pousada
-- ============================================================================

-- ============================================================================
-- 1. CONSULTAS BÁSICAS
-- ============================================================================

-- Listar todos os hóspedes
SELECT id, nome, email, telefone FROM hospedes ORDER BY nome;

-- Listar todos os quartos disponíveis
SELECT id, nome, capacidade, preco_diaria FROM quartos WHERE ativo = TRUE ORDER BY preco_diaria;

-- Listar todas as reservas
SELECT r.id, h.nome as hospede, q.nome as quarto, r.data_checkin, r.data_checkout, r.status
FROM reservas r
JOIN hospedes h ON r.hospede_id = h.id
JOIN quartos q ON r.quarto_id = q.id
ORDER BY r.data_checkin;

-- ============================================================================
-- 2. RESERVAS
-- ============================================================================

-- Reservas ativas (confirmadas ou pendentes)
SELECT r.id, h.nome, q.nome, r.data_checkin, r.data_checkout
FROM reservas r
JOIN hospedes h ON r.hospede_id = h.id
JOIN quartos q ON r.quarto_id = q.id
WHERE r.status IN ('confirmada', 'pendente')
ORDER BY r.data_checkin;

-- Quartos ocupados em um período
SELECT DISTINCT q.id, q.nome, q.capacidade
FROM quartos q
JOIN reservas r ON q.id = r.quarto_id
WHERE r.status != 'cancelada'
  AND r.data_checkin <= '2026-07-15'
  AND r.data_checkout >= '2026-07-10';

-- Quartos disponíveis em um período
SELECT id, nome, capacidade, preco_diaria
FROM quartos
WHERE ativo = TRUE
  AND id NOT IN (
    SELECT q.id FROM quartos q
    JOIN reservas r ON q.id = r.quarto_id
    WHERE r.status != 'cancelada'
      AND r.data_checkin <= '2026-07-15'
      AND r.data_checkout >= '2026-07-10'
  );

-- ============================================================================
-- 3. PRODUTOS E INGREDIENTES
-- ============================================================================

-- Produtos com lista de ingredientes
SELECT p.id, p.nome as produto, i.nome as ingrediente, pi.quantidade_usada, i.unidade
FROM produtos p
JOIN produto_ingrediente pi ON p.id = pi.produto_id
JOIN ingredientes i ON pi.ingrediente_id = i.id
ORDER BY p.nome, i.nome;

-- Custo total de cada produto
SELECT 
  p.id,
  p.nome,
  p.preco_venda,
  COALESCE(SUM(i.preco * pi.quantidade_usada), 0) as custo_ingredientes,
  p.preco_venda - COALESCE(SUM(i.preco * pi.quantidade_usada), 0) as lucro
FROM produtos p
LEFT JOIN produto_ingrediente pi ON p.id = pi.produto_id
LEFT JOIN ingredientes i ON pi.ingrediente_id = i.id
GROUP BY p.id, p.nome, p.preco_venda
ORDER BY lucro DESC;

-- Ingredientes com baixo estoque (menos de 5 unidades)
SELECT id, nome, quantidade, unidade
FROM ingredientes
WHERE quantidade < 5
  AND ativo = TRUE
ORDER BY quantidade ASC;

-- ============================================================================
-- 4. ANÁLISES E RELATÓRIOS
-- ============================================================================

-- Receita total de reservas em um período
SELECT 
  SUM((r.data_checkout - r.data_checkin) * q.preco_diaria) as receita_total
FROM reservas r
JOIN quartos q ON r.quarto_id = q.id
WHERE r.status = 'concluida'
  AND r.data_checkout BETWEEN '2026-07-01' AND '2026-07-31';

-- Hóspedes com mais reservas
SELECT 
  h.id,
  h.nome,
  COUNT(r.id) as total_reservas,
  SUM(r.data_checkout - r.data_checkin) as total_noites
FROM hospedes h
LEFT JOIN reservas r ON h.id = r.hospede_id
GROUP BY h.id, h.nome
ORDER BY total_reservas DESC
LIMIT 10;

-- Taxa de ocupação dos quartos
SELECT 
  q.nome,
  COUNT(r.id) as total_reservas,
  ROUND(100.0 * COUNT(r.id) / NULLIF((SELECT COUNT(*) FROM reservas), 0), 2) as percentual_ocupacao
FROM quartos q
LEFT JOIN reservas r ON q.id = r.quarto_id AND r.status IN ('confirmada', 'concluida')
GROUP BY q.id, q.nome
ORDER BY percentual_ocupacao DESC;
