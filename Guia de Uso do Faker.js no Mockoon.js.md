# Guia de Uso do Faker.js no Mockoon

Este guia explica como utilizar o Faker.js no Mockoon para gerar dados dinâmicos em suas APIs mock, permitindo respostas mais realistas e variadas.

## 1. O que é o Faker.js?

O Faker.js é uma biblioteca que permite gerar grandes quantidades de dados falsos, mas realistas, como nomes, endereços, números de telefone, e-mails, datas, entre outros. No Mockoon, o Faker.js está integrado e pode ser usado diretamente nas respostas JSON.

## 2. Sintaxe Básica do Faker no Mockoon

Para usar o Faker.js no Mockoon, você utiliza a seguinte sintaxe dentro do corpo da resposta JSON:

```
{{faker 'namespace.método' parâmetros}}
```

Onde:
- `namespace` é a categoria do dado (como 'person', 'number', 'date', etc.)
- `método` é o tipo específico de dado dentro da categoria
- `parâmetros` são opcionais e dependem do método utilizado

## 3. Namespaces e Métodos Comuns do Faker.js

### Dados Pessoais
```json
"nome": "{{faker 'person.fullName'}}",
"primeiroNome": "{{faker 'person.firstName'}}",
"sobrenome": "{{faker 'person.lastName'}}",
"cargo": "{{faker 'person.jobTitle'}}",
"sexo": "{{faker 'person.sex'}}",
"cpf": "{{faker 'string.numeric' length=11}}"
```

### Endereços
```json
"rua": "{{faker 'location.street'}}",
"cidade": "{{faker 'location.city'}}",
"estado": "{{faker 'location.state'}}",
"siglaEstado": "{{faker 'location.stateAbbr'}}",
"pais": "{{faker 'location.country'}}",
"cep": "{{faker 'location.zipCode'}}"
```

### Números e Valores
```json
"numeroInteiro": "{{faker 'number.int' max=1000}}",
"numeroDecimal": "{{faker 'number.float' max=1000 precision=2}}",
"preco": "{{faker 'commerce.price' min=10 max=1000 dec=2}}",
"porcentagem": "{{faker 'number.float' min=0 max=100 precision=2}}"
```

### Datas e Horas
```json
"dataAtual": "{{now 'YYYY-MM-DD'}}",
"dataPassada": "{{faker 'date.past' days=30 refDate='2023-01-01' format='YYYY-MM-DD'}}",
"dataFutura": "{{faker 'date.future' days=30 refDate='2023-01-01' format='YYYY-MM-DD'}}",
"horaAleatoria": "{{faker 'date.time'}}"
```

### Valores Booleanos e IDs
```json
"ativo": "{{faker 'datatype.boolean'}}",
"id": "{{faker 'string.uuid'}}",
"codigo": "{{faker 'string.alphanumeric' length=8}}"
```

### Veículos (útil para API e-Frotas)
```json
"placa": "{{faker 'vehicle.vrm'}}",
"modelo": "{{faker 'vehicle.model'}}",
"marca": "{{faker 'vehicle.manufacturer'}}",
"cor": "{{faker 'vehicle.color'}}",
"tipo": "{{faker 'vehicle.type'}}",
"combustivel": "{{faker 'vehicle.fuel'}}"
```

## 4. Exemplos Práticos para a API e-Frotas

### Exemplo 1: Dados de Veículo
```json
{
  "placa": "{{request.params.placa}}",
  "renavam": "{{faker 'string.numeric' length=11}}",
  "descricaoMunicipioEmplacamento": "{{faker 'location.city'}}",
  "chassi": "{{faker 'string.alphanumeric' length=17 casing='upper'}}",
  "descricaoCor": "{{faker 'color.human'}}",
  "anoFabricacao": {{faker 'number.int' min=2000 max=2025}},
  "anoModelo": {{faker 'number.int' min=2000 max=2025}},
  "descricaoCombustivel": "{{faker 'helpers.arrayElement' array='["FLEX","GASOLINA","DIESEL","ETANOL","ELÉTRICO"]'}}",
  "descricaoTipoVeiculo": "{{faker 'helpers.arrayElement' array='["AUTOMOVEL","CAMINHONETE","MOTOCICLETA","ONIBUS"]'}}",
  "descricaoEspecie": "{{faker 'helpers.arrayElement' array='["PASSAGEIRO","CARGA","MISTO"]'}}",
  "descricaoCategoria": "{{faker 'helpers.arrayElement' array='["PARTICULAR","ALUGUEL","OFICIAL"]'}}",
  "procedencia": "{{faker 'helpers.arrayElement' array='["NACIONAL","IMPORTADO"]'}}",
  "ufJurisdicao": "{{faker 'location.stateAbbr'}}",
  "quantidadeTotalRestricoes": {{faker 'number.int' min=0 max=5}},
  "descricaoMarcaModelo": "{{faker 'vehicle.manufacturer'}} {{faker 'vehicle.model'}}",
  "proprietario": {
    "tipoDocumento": "{{faker 'helpers.arrayElement' array='["CPF","CNPJ"]'}}",
    "numeroDocumento": "{{faker 'string.numeric' length=11}}"
  },
  "indicadores": {
    "rouboFurto": {{faker 'datatype.boolean'}},
    "recall": {{faker 'datatype.boolean'}},
    "comunicacaoVenda": {{faker 'datatype.boolean'}},
    "renajud": {{faker 'datatype.boolean'}},
    "infracoesExigiveis": {{faker 'datatype.boolean'}}
  },
  "versao": "1.0.0"
}
```

### Exemplo 2: Dados de Infração
```json
{
  "codigoOrgaoAutuador": "{{faker 'string.numeric' length=3}}",
  "numeroAutoInfracao": "{{faker 'string.alphanumeric' length=10 casing='upper'}}",
  "codigoInfracao": "{{faker 'string.numeric' length=4}}",
  "ufOrgaoAutuador": "{{faker 'location.stateAbbr'}}",
  "valorIntegralInfracao": {{faker 'number.float' min=100 max=1000 precision=2}},
  "descricaoInfracao": "{{faker 'helpers.arrayElement' array='["Excesso de velocidade","Estacionamento irregular","Dirigir sem cinto de segurança","Ultrapassagem proibida","Dirigir sob influência de álcool"]'}}",
  "dataVencimentoPenalidade": "{{faker 'date.future' days=30 format='YYYY-MM-DD'}}",
  "dataPagamento": null,
  "placa": "{{request.params.placa}}",
  "gravidade": "{{faker 'helpers.arrayElement' array='["leve","média","grave","gravíssima"]'}}",
  "dataLimiteDefesaAutuacao": "{{faker 'date.future' days=15 format='YYYY-MM-DD'}}",
  "localAutuacao": "{{faker 'location.street'}}",
  "descricaoMunicipioAutuacao": "{{faker 'location.city'}}",
  "dataAutuacao": "{{faker 'date.past' days=15 format='YYYY-MM-DD'}}",
  "horaAutuacao": "{{faker 'date.time'}}",
  "indicadorExigibilidade": {{faker 'datatype.boolean'}},
  "indicadorFotoRecebida": {{faker 'datatype.boolean'}}
}
```

## 5. Usando Parâmetros da Requisição

Você pode combinar o Faker.js com parâmetros da requisição:

```json
{
  "placa": "{{request.params.placa}}",
  "proprietario": "{{faker 'person.fullName'}}",
  "dataConsulta": "{{now 'YYYY-MM-DD HH:mm:ss'}}"
}
```

## 6. Gerando Arrays Dinâmicos

Para gerar arrays com múltiplos itens:

```json
[
  {{#repeat 5}}
  {
    "id": "{{faker 'string.uuid'}}",
    "placa": "{{faker 'vehicle.vrm'}}",
    "modelo": "{{faker 'vehicle.model'}}",
    "anoFabricacao": {{faker 'number.int' min=2000 max=2025}},
    "proprietario": "{{faker 'person.fullName'}}"
  }{{#unless @last}},{{/unless}}
  {{/repeat}}
]
```

## 7. Dicas Avançadas

### Combinando Valores
```json
"nomeCompleto": "{{faker 'person.firstName'}} {{faker 'person.lastName'}}",
"enderecoCompleto": "{{faker 'location.street'}}, {{faker 'location.buildingNumber'}}, {{faker 'location.city'}} - {{faker 'location.stateAbbr'}}"
```

### Usando Helpers para Seleção Aleatória
```json
"status": "{{faker 'helpers.arrayElement' array='["ATIVO","INATIVO","SUSPENSO","BLOQUEADO"]'}}",
"categoria": "{{faker 'helpers.arrayElement' array='["A","B","C","D","E","AB"]'}}"
```

### Gerando Dados Consistentes
Para gerar o mesmo valor aleatório várias vezes na mesma resposta:

```json
{{#let "placa" (faker 'vehicle.vrm')}}
{
  "veiculo": {
    "placa": "{{placa}}",
    "detalhes": {
      "placa": "{{placa}}",
      "modelo": "{{faker 'vehicle.model'}}"
    }
  }
}
{{/let}}
```

## 8. Referência Completa do Faker.js

Para uma lista completa de todos os métodos disponíveis no Faker.js, consulte a [documentação oficial do Faker.js](https://fakerjs.dev/api/).

## 9. Solução de Problemas Comuns

### Problema: Valores não estão sendo gerados
- **Solução**: Verifique se a sintaxe está correta e se o templating está habilitado (desmarque "Disable templating" nas configurações da resposta)

### Problema: Erro ao usar arrays ou objetos como parâmetros
- **Solução**: Use aspas simples para delimitar strings e certifique-se de que o JSON está bem formatado

### Problema: Valores gerados não são realistas para o Brasil
- **Solução**: O Faker.js tem suporte limitado para dados brasileiros. Para CPFs, CNPJs e outros dados específicos, você pode precisar criar padrões personalizados usando `string.numeric` ou `string.alphanumeric`
