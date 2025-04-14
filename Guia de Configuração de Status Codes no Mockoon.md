# Guia de Configuração de Status Codes no Mockoon

Este guia explica como configurar diferentes status codes HTTP em suas respostas do Mockoon, permitindo simular diversos cenários de API, incluindo sucesso, erros e situações especiais.

## 1. Entendendo Status Codes HTTP

Os status codes HTTP são códigos numéricos que indicam o resultado de uma requisição. Eles são agrupados em cinco categorias:

- **1xx (Informacional)**: A requisição foi recebida e o processo continua
- **2xx (Sucesso)**: A requisição foi recebida, entendida e aceita com sucesso
- **3xx (Redirecionamento)**: Ações adicionais são necessárias para completar a requisição
- **4xx (Erro do Cliente)**: A requisição contém sintaxe incorreta ou não pode ser atendida
- **5xx (Erro do Servidor)**: O servidor falhou ao atender uma requisição aparentemente válida

## 2. Configurando Status Codes Básicos no Mockoon

### Passo 1: Adicionar Múltiplas Respostas a um Endpoint

No Mockoon, você pode configurar múltiplas respostas para um mesmo endpoint:

1. Selecione a rota desejada no painel lateral
2. Na seção "Responses", clique no botão "+" para adicionar uma nova resposta
3. Configure o status code e o corpo da resposta para cada cenário

### Passo 2: Configurar o Status Code

Para cada resposta:

1. No campo "Status code", digite o código HTTP desejado (ex: 200, 400, 500)
2. Adicione um "Label" descritivo para identificar a resposta (ex: "Sucesso", "Erro de validação")
3. Configure o corpo da resposta de acordo com o status code

## 3. Status Codes Comuns e Seus Usos

### Respostas de Sucesso (2xx)

```json
// 200 OK - Requisição bem-sucedida
{
  "statusCode": 200,
  "body": {
    "placa": "ABC1234",
    "renavam": "12345678901",
    "mensagem": "Veículo encontrado com sucesso"
  }
}

// 201 Created - Recurso criado com sucesso
{
  "statusCode": 201,
  "body": {
    "id": "{{faker 'string.uuid'}}",
    "mensagem": "Veículo cadastrado com sucesso",
    "timestamp": "{{now}}"
  }
}

// 204 No Content - Requisição bem-sucedida, sem conteúdo para retornar
{
  "statusCode": 204,
  "body": ""
}
```

### Respostas de Erro do Cliente (4xx)

```json
// 400 Bad Request - Requisição inválida
{
  "statusCode": 400,
  "body": {
    "erro": "Requisição inválida",
    "detalhes": "Parâmetros obrigatórios não informados",
    "campos": ["placa", "renavam"]
  }
}

// 401 Unauthorized - Autenticação necessária
{
  "statusCode": 401,
  "body": {
    "erro": "Não autorizado",
    "mensagem": "Autenticação necessária para acessar este recurso"
  }
}

// 403 Forbidden - Acesso negado
{
  "statusCode": 403,
  "body": {
    "erro": "Acesso negado",
    "mensagem": "Você não tem permissão para acessar este recurso"
  }
}

// 404 Not Found - Recurso não encontrado
{
  "statusCode": 404,
  "body": {
    "erro": "Não encontrado",
    "mensagem": "Veículo com placa ABC1234 não encontrado"
  }
}

// 422 Unprocessable Entity - Validação falhou
{
  "statusCode": 422,
  "body": {
    "erro": "Erro de validação",
    "detalhes": [
      {
        "campo": "placa",
        "mensagem": "Formato de placa inválido"
      },
      {
        "campo": "renavam",
        "mensagem": "Renavam deve conter 11 dígitos numéricos"
      }
    ]
  }
}

// 429 Too Many Requests - Limite de requisições excedido
{
  "statusCode": 429,
  "body": {
    "erro": "Muitas requisições",
    "mensagem": "Limite de requisições excedido. Tente novamente em 60 segundos",
    "limitePorMinuto": 15
  }
}
```

### Respostas de Erro do Servidor (5xx)

```json
// 500 Internal Server Error - Erro interno do servidor
{
  "statusCode": 500,
  "body": {
    "erro": "Erro interno do servidor",
    "mensagem": "Ocorreu um erro inesperado. Por favor, tente novamente mais tarde",
    "idRastreamento": "{{faker 'string.uuid'}}"
  }
}

// 503 Service Unavailable - Serviço indisponível
{
  "statusCode": 503,
  "body": {
    "erro": "Serviço indisponível",
    "mensagem": "O serviço está temporariamente indisponível para manutenção",
    "previsaoRetorno": "{{faker 'date.future' minutes=30 format='YYYY-MM-DD HH:mm:ss'}}"
  }
}
```

## 4. Configurando Regras para Diferentes Status Codes

No Mockoon, você pode definir regras para determinar qual resposta será retornada:

### Passo 1: Adicionar Regras a uma Resposta

1. Selecione a resposta desejada
2. Na seção "Rules", clique em "Add a rule"
3. Configure a regra com base em parâmetros, cabeçalhos, corpo ou query string

### Passo 2: Configurar a Lógica da Regra

Exemplo de regras:

- Retornar 404 se a placa não existir:
  - Target: `params`
  - Modifier: `placa`
  - Value: `ABC1234`
  - Operator: `not equals`

- Retornar 400 se faltar parâmetro obrigatório:
  - Target: `query`
  - Modifier: `dataInicial`
  - Value: ``
  - Operator: `equals`

- Retornar 401 se o token estiver ausente:
  - Target: `headers`
  - Modifier: `Authorization`
  - Value: ``
  - Operator: `equals`

## 5. Exemplos Práticos para a API e-Frotas

### Exemplo 1: Consulta de Veículo por Placa

Configurar múltiplas respostas para o endpoint `consultas/v1/veiculos/placa/:placa`:

#### Resposta 1: Veículo encontrado (200 OK)
```json
{
  "statusCode": 200,
  "body": {
    "placa": "{{request.params.placa}}",
    "renavam": "{{faker 'string.numeric' length=11}}",
    "descricaoMunicipioEmplacamento": "{{faker 'location.city'}}",
    "chassi": "{{faker 'string.alphanumeric' length=17 casing='upper'}}",
    "descricaoCor": "{{faker 'color.human'}}",
    "anoFabricacao": {{faker 'number.int' min=2000 max=2025}},
    "anoModelo": {{faker 'number.int' min=2000 max=2025}},
    "descricaoCombustivel": "FLEX",
    "descricaoTipoVeiculo": "AUTOMOVEL",
    "descricaoEspecie": "PASSAGEIRO",
    "descricaoCategoria": "PARTICULAR",
    "procedencia": "NACIONAL",
    "ufJurisdicao": "SP",
    "quantidadeTotalRestricoes": 0,
    "descricaoMarcaModelo": "FIAT/PALIO",
    "proprietario": {
      "tipoDocumento": "CPF",
      "numeroDocumento": "12345678900"
    },
    "indicadores": {
      "rouboFurto": false,
      "recall": false,
      "comunicacaoVenda": false,
      "renajud": false,
      "infracoesExigiveis": true
    },
    "versao": "1.0.0"
  }
}
```

#### Resposta 2: Veículo não encontrado (404 Not Found)
```json
{
  "statusCode": 404,
  "body": {
    "mensagem": "Veículo com placa {{request.params.placa}} não encontrado",
    "mensagemTecnica": "Registro não localizado na base de dados"
  }
}
```
Regra: Retornar esta resposta se `placa` for igual a "ZZZ9999"

#### Resposta 3: Acesso não autorizado (403 Forbidden)
```json
{
  "statusCode": 403,
  "body": {
    "mensagem": "Consulta não autorizada",
    "mensagemTecnica": "O CNPJ informado não possui autorização para consultar este veículo"
  }
}
```
Regra: Retornar esta resposta se `placa` for igual a "XXX8888"

#### Resposta 4: Erro interno (500 Internal Server Error)
```json
{
  "statusCode": 500,
  "body": {
    "mensagem": "Erro interno do servidor",
    "mensagemTecnica": "Falha na comunicação com o serviço RENAVAM",
    "idRastreamento": "{{faker 'string.uuid'}}"
  }
}
```
Regra: Retornar esta resposta se `placa` for igual a "ERR5000"

## 6. Configurando Latência e Cabeçalhos

Além do status code, você pode configurar:

### Latência
Adicione latência para simular tempos de resposta realistas:
1. No campo "Latency", digite o tempo em milissegundos (ex: 1000 para 1 segundo)

### Cabeçalhos de Resposta
Adicione cabeçalhos HTTP personalizados:
1. Na seção "Headers", clique em "Add header"
2. Configure pares chave-valor (ex: `Content-Type: application/json`)

Cabeçalhos úteis para diferentes status codes:
```
// Para 429 Too Many Requests
Retry-After: 60

// Para 401 Unauthorized
WWW-Authenticate: Bearer

// Para 503 Service Unavailable
Retry-After: 3600
```

## 7. Combinando Status Codes com Faker.js

Você pode combinar status codes com dados dinâmicos do Faker.js:

```json
// Erro 500 com ID de rastreamento dinâmico
{
  "statusCode": 500,
  "body": {
    "erro": "Erro interno do servidor",
    "mensagem": "Ocorreu um erro inesperado",
    "idRastreamento": "{{faker 'string.uuid'}}",
    "timestamp": "{{now 'YYYY-MM-DD HH:mm:ss'}}"
  }
}

// Erro 429 com tempo de espera dinâmico
{
  "statusCode": 429,
  "body": {
    "erro": "Muitas requisições",
    "mensagem": "Limite de requisições excedido",
    "aguardeSegundos": {{faker 'number.int' min=30 max=120}},
    "limitePorMinuto": 15
  }
}
```

## 8. Dicas Avançadas

### Simulando Falhas Intermitentes
Configure uma resposta de erro com uma regra baseada em probabilidade:

1. Adicione uma resposta com status code 500
2. Adicione uma regra:
   - Target: `faker`
   - Modifier: `datatype.boolean` 
   - Value: `true`
   - Operator: `equals`
   
Isso fará com que a API falhe aleatoriamente em aproximadamente 50% das requisições.

### Simulando Diferentes Ambientes
Configure diferentes respostas para simular ambientes de desenvolvimento, homologação e produção:

1. Adicione uma resposta para cada ambiente
2. Adicione regras baseadas em um cabeçalho personalizado:
   - Target: `headers`
   - Modifier: `X-Environment`
   - Value: `dev` (ou `hom`, `prod`)
   - Operator: `equals`

## 9. Solução de Problemas Comuns

### Problema: Resposta errada sendo retornada
- **Solução**: Verifique a ordem das respostas e as regras configuradas. O Mockoon avalia as respostas na ordem em que aparecem.

### Problema: Status code configurado, mas corpo da resposta não corresponde
- **Solução**: Certifique-se de que o corpo da resposta está formatado corretamente para o status code escolhido.

### Problema: Regras não funcionando como esperado
- **Solução**: Verifique se o operador lógico entre as regras está correto (AND/OR) e se os valores estão sendo comparados corretamente.
