# Guia de Execução do Mockoon em Docker

Este guia explica como executar o ambiente Mockoon para a API e-Frotas em um container Docker.

## Pré-requisitos

- Docker instalado ([Guia de instalação do Docker](https://docs.docker.com/get-docker/))
- Docker Compose instalado (opcional, mas recomendado - [Guia de instalação](https://docs.docker.com/compose/install/))

## Estrutura de Arquivos

```text

mockoon-api/
├── Dockerfile                           # Configuração para construir a imagem Docker
├── docker-compose.yml                   # Configuração do Docker Compose (opcional)
└── mockoon-config-from-openapi.json     # Arquivo de configuração do Mockoon
```

## Opção 1: Usando Docker Compose (Recomendado)

O Docker Compose simplifica o gerenciamento do container e permite iniciar/parar facilmente o serviço.

### Iniciar o Serviço

```bash
# Na pasta onde está o arquivo docker-compose.yml
docker-compose up -d
```

### Verificar Status

```bash
docker-compose ps
```

### Visualizar Logs

```bash
docker-compose logs -f
```

### Parar o Serviço

```bash
docker-compose down
```

### Reiniciar o Serviço (após alterações no arquivo de configuração)

```bash
docker-compose restart
```

## Opção 2: Usando Docker Diretamente

Se preferir não usar o Docker Compose, você pode usar os comandos Docker diretamente.

### Construir a Imagem

```bash
# Na pasta onde está o Dockerfile
docker build -t mockoon-efrotas .
```

### Executar o Container

```bash
docker run -d --name mockoon-efrotas -p 3002:3002 -v $(pwd)/mockoon-config-from-openapi.json:/app/mockoon-config-from-openapi.json mockoon-efrotas
```

### Verificar Status Container

```bash
docker ps
```

### Visualizar Logs Container

```bash
docker logs -f mockoon-efrotas
```

### Parar o Container

```bash
docker stop mockoon-efrotas
```

### Remover o Container

```bash
docker rm mockoon-efrotas
```

## Testando a API

Após iniciar o container, a API estará disponível em:

```text
http://localhost:3002/
```

Exemplo de teste:

```bash
curl http://localhost:3002/consultas/v1/veiculos/placa/ABC1234
```

## Atualizando a Configuração

Se você modificar o arquivo `mockoon-config-from-openapi.json`, as alterações serão aplicadas automaticamente se estiver usando volumes (como configurado no Docker Compose). Caso contrário, será necessário reconstruir a imagem e reiniciar o container.

## Solução de Problemas

### Porta já em uso

Se a porta 3002 já estiver em uso, você pode alterar o mapeamento de porta no arquivo `docker-compose.yml` ou no comando `docker run`:

```yaml
# Em docker-compose.yml
ports:
  - "3003:3002"  # Mapeia a porta 3003 do host para a porta 3002 do container
```

```bash
# Com docker run
docker run -d --name mockoon-efrotas -p 3003:3002 -v $(pwd)/mockoon-config-from-openapi.json:/app/mockoon-config-from-openapi.json mockoon-efrotas
```

### Container não inicia

Verifique os logs para identificar o problema:

```bash
docker logs mockoon-efrotas
```
