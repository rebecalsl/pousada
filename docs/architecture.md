# Arquitetura

O projeto esta organizado como uma aplicacao front-end estatica, pronta para evoluir para uma SPA ou consumir uma API no futuro.

## Decisoes

- `frontend/index.html` concentra a estrutura sem dependencias externas.
- `frontend/src/styles.css` define o design responsivo e componentes reutilizaveis.
- `frontend/src/app.js` renderiza dados demonstrativos e controla navegacao, status e dialogos.
- `database/schema.sql` consolida os scripts SQL originais em um unico ponto de manutencao.

## Evolucao recomendada

Quando houver backend, mova os arrays de dados do `app.js` para chamadas HTTP e mantenha a mesma estrutura visual.
