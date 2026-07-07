# 🏨 Pousada - Sistema de Gerenciamento

## 📋 Descrição

Projeto de banco de dados para gerenciamento de uma pousada. Inclui módulos para:
- Gerenciamento de hóspedes
- Gerenciamento de quartos
- Sistema de reservas
- Controle de ingredientes e produtos

## 📁 Estrutura do Projeto

```
pousada/
├── README.md                    # Este arquivo
├── docs/
│   └── DIAGRAMA_ER.md          # Diagrama Entidade-Relacionamento
├── sql/
│   ├── 01-schema/
│   │   ├── hospedes.sql        # Tabela de hóspedes
│   │   ├── quartos.sql         # Tabela de quartos
│   │   ├── reservas.sql        # Tabela de reservas
│   │   └── produtos/
│   │       ├── ingredientes.sql # Tabela de ingredientes
│   │       ├── produtos.sql    # Tabela de produtos
│   │       └── produto_ingrediente.sql # Relação produtos-ingredientes
│   ├── 02-data/
│   │   └── seeds.sql           # Dados iniciais (quando houver)
│   └── 03-queries/
│       └── exemplos.sql        # Queries de exemplo
└── .gitignore
```

## 🗄️ Tabelas do Banco de Dados

### 1. **hospedes**
Armazena informações dos hóspedes da pousada.

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| nome | VARCHAR(150) | Nome do hóspede |
| telefone | VARCHAR(20) | Telefone de contato |
| email | VARCHAR(150) | Email do hóspede |

### 2. **quartos**
Cadastro dos quartos disponíveis.

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| nome | VARCHAR(100) | Nome/número do quarto |
| descricao | TEXT | Descrição do quarto |
| capacidade | INT | Número de pessoas |
| preco_diaria | DECIMAL(10,2) | Preço por diária |

### 3. **reservas**
Sistema de reservas de quartos.

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| hospede_id | INT FK | Referência ao hóspede |
| quarto_id | INT FK | Referência ao quarto |
| data_checkin | DATE | Data de entrada |
| data_checkout | DATE | Data de saída |
| status | VARCHAR(50) | Status da reserva |

### 4. **ingredientes**
Catálogo de ingredientes disponíveis.

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| nome | VARCHAR(100) | Nome do ingrediente |
| preco | DECIMAL(10,2) | Preço unitário |
| quantidade | DECIMAL(10,2) | Quantidade em estoque |

### 5. **produtos**
Produtos (lanches, marmitas, etc) oferecidos.

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| nome | VARCHAR(100) | Nome do produto |

### 6. **produto_ingrediente**
Relação entre produtos e ingredientes (muitos para muitos).

| Campo | Tipo | Descrição |
|-------|------|----------|
| id | SERIAL PRIMARY KEY | Identificador único |
| produto_id | INT FK | Referência ao produto |
| ingrediente_id | INT FK | Referência ao ingrediente |
| quantidade_usada | DECIMAL(10,2) | Quantidade usada no produto |

## 🚀 Como Usar

### 1. Criar o Banco de Dados
```bash
# PostgreSQL
psql -U seu_usuario -d sua_database -f sql/01-schema/hospedes.sql
psql -U seu_usuario -d sua_database -f sql/01-schema/quartos.sql
psql -U seu_usuario -d sua_database -f sql/01-schema/reservas.sql
# ... e assim por diante
```

### 2. Carregar Dados Iniciais
```bash
psql -U seu_usuario -d sua_database -f sql/02-data/seeds.sql
```

### 3. Executar Queries de Exemplo
Veja o arquivo `sql/03-queries/exemplos.sql` para queries úteis.

## 📚 Documentação Adicional

- [Diagrama Entidade-Relacionamento](docs/DIAGRAMA_ER.md)

## 📝 Licença

MIT License - Sinta-se livre para usar este projeto!

## 👤 Autor

Rebecalsl
