#!/bin/bash

# Script para construir e executar o Mockoon em Docker

# Cores para melhor visualização
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Construindo a imagem Docker para o Mockoon ===${NC}"
docker build -t mockoon-efrotas .

echo -e "${YELLOW}=== Verificando se já existe um container com o mesmo nome ===${NC}"
if [ "$(docker ps -aq -f name=mockoon-efrotas)" ]; then
    echo -e "${YELLOW}Container existente encontrado. Removendo...${NC}"
    docker stop mockoon-efrotas
    docker rm mockoon-efrotas
fi

echo -e "${YELLOW}=== Iniciando o container Mockoon ===${NC}"
docker run -d --name mockoon-efrotas -p 3002:3002 -v "$(pwd)/mockoon-config-from-openapi.json:/app/mockoon-config-from-openapi.json" mockoon-efrotas

echo -e "${YELLOW}=== Verificando status do container ===${NC}"
docker ps -f name=mockoon-efrotas

echo -e "${GREEN}=== Mockoon está rodando em http://localhost:3002 ===${NC}"
echo -e "${GREEN}=== Use 'docker logs -f mockoon-efrotas' para ver os logs ===${NC}"
