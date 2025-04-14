# Ambiente de Mock para API e-Frotas

Este projeto configura um ambiente de mock para a API e-Frotas usando o Mockoon CLI, permitindo testar aplicações que consomem essa API sem depender do ambiente real.

## Requisitos

- Node.js (v14 ou superior)
- NPM (v6 ou superior)

## Instalação

Para configurar o ambiente de mock, siga os passos abaixo:

```bash

npm i -g @mockoon/cli

mockoon-cli --version
```

## Configurando a api // Simples

### importando o openapi.yml para o json do Mockoon

```cmd

mockoon-cli import -i ./openapi-simple.yml -o ./mockoon-config-from-openapi-simple.json -p
```

### Iniciando o Mockon server

```cmd

mockoon-cli start --data ./mockoon-config-from-openapi-simple.json --hostname 0.0.0.0 --port 3000
```

### Teste

```cmd

http://localhost:3000/consultas/v1/veiculos/placa/ABC0A01
```

## Configurando a api // E-frotas

### importando o openapi

```cmd

mockoon-cli import -i ./openapi-efrotas-estaleiro-nosecurity.yml -o ./mockoon-config-from-openapi-efrotas-nosecurity.json -p
```

### Iniciando com a configuração

```cmd

mockoon-cli start --data ./mockoon-config-from-openapi-efrotas-nosecurity.json --hostname 0.0.0.0 --port 3000
```

## Outras Configurações

- exemplo-faker-js.json
- exemplo-status-codes.json
- mockoon-config-efrotas-completo.json

### Completo

```bash

mockoon-cli start --data ./mockoon-config-efrotas-completo.json --hostname 0.0.0.0 --port 3000
```

#### Testes

```bash
# Consulta normal (sucesso)
curl http://localhost:3000/consultas/v1/veiculos/placa/ABC1234

# Consulta com erro 404 (não encontrado)
curl http://localhost:3000/consultas/v1/veiculos/placa/ERR404

# Consulta com erro 403 (não autorizado)
curl http://localhost:3000/consultas/v1/veiculos/placa/ERR403

# Consulta com erro 500 (erro interno)
curl http://localhost:3000/consultas/v1/veiculos/placa/ERR500

# Consulta com erro 429 (muitas requisições)
curl http://localhost:3000/consultas/v1/veiculos/placa/ERR429

# Teste de falha intermitente (50% de chance de erro 503)
curl http://localhost:3000/sistema/status

```
