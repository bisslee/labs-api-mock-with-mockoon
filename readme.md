# Ambiente de Mock para API e-Frotas

Este projeto configura um ambiente de mock para a API e-Frotas usando o Mockoon CLI, permitindo testar aplicações que consomem essa API sem depender do ambiente real.

## Requisitos

- Node.js (v14 ou superior)
- NPM (v6 ou superior)

## Instalação

Para configurar o ambiente de mock, siga os passos abaixo:
npm i -g @mockoon/cli

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
