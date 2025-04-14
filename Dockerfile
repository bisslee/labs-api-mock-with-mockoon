FROM node:18-alpine

# Instalar o Mockoon CLI globalmente
RUN npm install -g @mockoon/cli

# Criar diretório de trabalho
WORKDIR /app

# Copiar o arquivo de configuração do Mockoon
COPY mockoon-config-from-openapi.json /app/

# Expor a porta que o Mockoon usará
EXPOSE 3002

# Comando para iniciar o Mockoon
CMD ["mockoon-cli", "start", "--data", "/app/mockoon-config-from-openapi.json", "--hostname", "0.0.0.0", "--port", "3002"]
