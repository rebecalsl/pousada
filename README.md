# Pousada

Sistema web estatico para gerenciamento de uma pousada, com telas de dashboard, quartos, reservas e hospedes.

## Funcionalidades

- Dashboard com indicadores operacionais.
- Listagem de quartos com disponibilidade, capacidade e diaria.
- Tabela de reservas com status e periodo.
- Cadastro visual de hospedes com dados de contato.
- Estrutura PWA com manifest e service worker.
- Schema SQL consolidado para evolucao futura do backend.

## Estrutura

- `frontend/`: aplicacao web estatica.
- `frontend/src/`: estilos e JavaScript da interface.
- `database/schema.sql`: modelo inicial do banco.
- `docs/architecture.md`: notas de arquitetura.

## Como executar

Abra `frontend/index.html` no navegador.

Para testar o service worker, sirva a pasta `frontend/` com um servidor local HTTP, por exemplo:

`python -m http.server 8000 -d frontend`

Depois acesse `http://localhost:8000`.

## Proximos passos sugeridos

- Separar os dados demonstrativos em uma API real.
- Adicionar autenticacao para usuarios administrativos.
- Criar formularios persistentes para quartos, reservas e hospedes.
- Automatizar testes de interface.
