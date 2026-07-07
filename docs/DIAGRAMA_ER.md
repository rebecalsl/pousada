# 📊 Diagrama Entidade-Relacionamento (ER)

## Estrutura do Banco de Dados - Pousada

```
┌─────────────────┐         ┌──────────────────┐
│    HOSPEDES     │         │    QUARTOS       │
├─────────────────┤         ├──────────────────┤
│ PK id (SERIAL)  │         │ PK id (SERIAL)   │
│    nome         │         │    nome          │
│    telefone     │         │    descricao     │
│    email        │         │    capacidade    │
│    data_criação │         │    preco_diaria  │
│    ativo        │         │    ativo         │
└────────┬────────┘         └────────┬─────────┘
         │                          │
         │ 1:N                      │ 1:N
         │                          │
         └──────────────┬───────────┘
                        │
                        │
                   ┌────▼────────┐
                   │   RESERVAS   │
                   ├──────────────┤
                   │ PK id        │
                   │ FK hospede_id│──────┐
                   │ FK quarto_id │──────┐
                   │ data_checkin │      │
                   │ data_checkout│      │
                   │ status       │      │
                   │ observacoes  │      │
                   │ data_criação │      │
                   └──────────────┘      │
                                         │
                                         │
                 ┌───────────────────────┴─────────────────┐
                 │                                         │
                 │                                         │
          ┌──────▼────────┐                      ┌────────▼──────┐
          │   PRODUTOS    │                      │ INGREDIENTES  │
          ├───────────────┤                      ├───────────────┤
          │ PK id         │                      │ PK id         │
          │    nome       │                      │    nome       │
          │    descricao  │                      │    preco      │
          │ preco_venda   │                      │    quantidade │
          │    ativo      │                      │    unidade    │
          │ data_criacao  │                      │    ativo      │
          │data_atualizaçao                      │ data_criacao  │
          └──────┬────────┘                      └───────────────┘
                 │                                       ▲
                 │ N:N                                   │
                 │                                       │
                 │                    ┌──────────────────┘
                 │                    │
                 └────────┬───────────┘
                          │
                          │
                  ┌───────▼────────────┐
                  │PRODUTO_INGREDIENTE │
                  ├────────────────────┤
                  │ PK id              │
                  │ FK produto_id      │
                  │ FK ingrediente_id  │
                  │ quantidade_usada   │
                  │ data_criacao       │
                  └────────────────────┘
```

## Relacionamentos

### 1. HOSPEDES ↔ RESERVAS
- **Tipo**: 1:N (Um hóspede pode ter múltiplas reservas)
- **Integridade**: RESTRICT (não permite deletar hóspede com reservas)
- **Cascata**: UPDATE CASCADE (atualiza automaticamente)

### 2. QUARTOS ↔ RESERVAS
- **Tipo**: 1:N (Um quarto pode ter múltiplas reservas)
- **Integridade**: RESTRICT (não permite deletar quarto com reservas)
- **Cascata**: UPDATE CASCADE (atualiza automaticamente)

### 3. PRODUTOS ↔ PRODUTO_INGREDIENTE
- **Tipo**: 1:N
- **Integridade**: CASCADE (deleta ingredientes do produto quando produto é deletado)

### 4. INGREDIENTES ↔ PRODUTO_INGREDIENTE
- **Tipo**: 1:N
- **Integridade**: RESTRICT (não permite deletar ingrediente se usado em produto)

### 5. PRODUTOS ↔ INGREDIENTES (via PRODUTO_INGREDIENTE)
- **Tipo**: N:N (Muitos para muitos)
- **Descrição**: Um produto pode ter múltiplos ingredientes, um ingrediente pode ser usado em múltiplos produtos

## Atributos Especiais

### Restrições (Constraints)
- **CHECK**: Validações de dados (ex: preco > 0, data_checkout > data_checkin)
- **UNIQUE**: Campos que não podem ter duplicatas (ex: nome do quarto)
- **NOT NULL**: Campos obrigatórios

### Índices
Criados para melhorar performance em buscas comuns:
- Email e nome em hospedes
- Nome em quartos
- Status em reservas
- Data de check-in e check-out em reservas
- Nome em ingredientes e produtos

### Campos Padrão
- `data_criacao`: Timestamp automático
- `data_atualizacao`: Timestamp com atualização automática
- `ativo`: Boolean para soft-delete lógico

## Boas Práticas Aplicadas

✅ **Normalização**: Estrutura em 3ª Forma Normal (3NF)  
✅ **Integridade Referencial**: Foreign keys com restrições apropriadas  
✅ **Auditoria**: Campos de data de criação e atualização  
✅ **Performance**: Índices estratégicos  
✅ **Segurança**: Validações em nível de banco  
✅ **Soft-delete**: Campo `ativo` para manter histórico  
