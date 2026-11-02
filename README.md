# Aether Docs

Repositório central de documentação do [Aether](https://github.com/AetherGases): pesquisa, UX, requisitos, diagramas, modelos de dados e contratos de API. Aqui ficam os artefatos que não pertencem a um serviço específico. A documentação de cada serviço (como rodar, variáveis, rotas) fica no README do próprio repositório, listado no [perfil da organização](https://github.com/AetherGases).

## Conteúdo

| Caminho | O que é |
| --- | --- |
| `designThinking/` | Pesquisa de mercado e entrevistas (`aether_desk_research.pdf`) e matriz de priorização de funcionalidades |
| `Aether_Dinamica_de_Trabalho.pdf` | Dinâmica de trabalho do grupo (Instituto J&F, junho de 2026): divisão de responsabilidades por área técnica |
| `Principais_Sistemas_do_Aether.docx` | Visão geral dos sistemas do ecossistema |
| `Documentation-DEV.docx` | Documentação técnica para desenvolvedores |
| `diagramas/produto/` | Casos de uso do app e do site (draw.io) |
| `diagramas/database/` | Modelos conceitual e lógico do banco: `.brM3` (brModelo), `.pgerd` (pgAdmin ERD), e o modelo do MongoDB (`mong-3.png`) |
| `fluxogramas/` | Fluxogramas do app e do site e o fluxo do grafo de agentes (LangGraph) da IA |
| `diagrama_atividade_*.png` | Diagramas de atividade de criar e revisar relatório |
| `contratos/api/` | Contratos OpenAPI (veja o aviso abaixo) |

## Contratos de API

| Arquivo | Descreve | Situação |
| --- | --- | --- |
| `swagger-core-api.yml` | API monolítica (`aether-core-api`, **arquivado**): auth, perfil, inventário, calculadora de ROI e emissões | Histórico. Foi dividida nos microsserviços Java |
| `swagger-mongo.yml` | Gateway de IA: usuários, sessões e relatórios | Parcialmente defasado. Os caminhos usam o prefixo `/v1/ai/...`, e o [ms-aeko-hub](https://github.com/AetherGases/ms-aeko-hub) hoje expõe `/ai/...` |

A fonte de verdade dos contratos atuais é o Swagger de cada serviço (`/swagger-ui/index.html` nos serviços Java e `/docs` no hub, só com `ENV=development`). Ao mudar uma rota, atualize o contrato aqui apenas se ele ainda for usado como referência.

## Modelo de dados

O Aether usa dois bancos PostgreSQL: o do **1º ano** (cadastro, `dbAether1Year`) e o do **2º ano** (normalizado, `dbAether2Year`, usado pelos microsserviços), mais MongoDB para sessões de IA e notificações. O schema executável está no [aether-toolskit](https://github.com/AetherGases/aether-toolskit) (`init-postgres/`) e a replicação entre os dois PostgreSQL é feita pelo [aether-rpa](https://github.com/AetherGases/aether-rpa). Os diagramas desta pasta ajudam a entender o desenho, mas o SQL do toolskit é o que vale em caso de divergência.

## Como contribuir

1. Crie uma branch a partir de `main` (`docs/<assunto>` ou `feat/<assunto>`).
2. Prefira formatos abertos e editáveis (draw.io, Markdown, `.pgerd`) e exporte PNG/PDF só para leitura rápida.
3. Abra a PR usando o template, marcando se há novos diagramas ou mudança em contratos de API.
