# Nashville Housing - Limpeza de Dados com SQL

Projeto de estudo desenvolvido para praticar SQL Server e conceitos básicos de limpeza e transformação de dados.

## Sobre o projeto

Este projeto foi realizado como exercício de acompanhamento de uma aula do Alex The Analyst sobre limpeza de dados utilizando SQL Server.

As etapas foram reproduzidas durante o estudo para praticar e entender melhor conceitos de manipulação e transformação de dados.

## Dataset

O projeto utiliza o dataset **Nashville Housing**, contendo informações sobre vendas de imóveis, como endereço da propriedade, endereço do proprietário, valor de venda, data da venda e outras características relacionadas às transações.

Durante a exploração e limpeza dos dados foram identificados problemas como:

- valores ausentes em campos de endereço;
- informações de endereço armazenadas em uma única coluna;
- diferentes representações para valores categóricos;
- registros duplicados;
- colunas que deixaram de ser necessárias após as transformações.

A partir desses problemas, foram aplicadas consultas e transformações em SQL para tornar os dados mais padronizados e adequados para análises posteriores.

## Principais etapas

- Inspeção inicial dos dados
- Padronização de datas
- Preenchimento de valores nulos
- Separação de endereços em diferentes colunas
- Padronização de valores em `SoldAsVacant`
- Identificação e remoção de registros duplicados
- Remoção de colunas que deixaram de ser necessárias

## Tratamentos realizados 

### Preenchimento de endereços ausentes

Durante a limpeza foram identificados **29 registros com `PropertyAddress` nulo**.

Para tratar esses casos, foi realizado um *self join* da tabela utilizando `ParcelID`, buscando outro registro referente ao mesmo imóvel que possuísse o endereço preenchido. O `UniqueID` foi utilizado para garantir que registros diferentes fossem comparados.

Antes da atualização, a correspondência entre os registros foi verificada com uma consulta `SELECT`. Em seguida, foi utilizado `UPDATE` com `ISNULL` para preencher os endereços ausentes.

Com isso, os valores nulos de `PropertyAddress` puderam ser preenchidos utilizando informações já existentes na própria base.

### Padronização de valores em `SoldAsVacant`

Durante a exploração dos dados, foi identificado que a coluna `SoldAsVacant` utilizava diferentes representações para a mesma informação: `Y`, `N`, `Yes` e `No`.

Primeiro, foram utilizados `DISTINCT`, `COUNT` e `GROUP BY` para identificar os diferentes valores presentes na coluna e verificar sua frequência.

Em seguida, foi utilizada uma expressão `CASE` para testar a conversão de `Y` para `Yes` e de `N` para `No`, mantendo os demais valores. Após verificar o resultado da consulta, a mesma lógica foi aplicada em um `UPDATE`.

Com isso, a coluna passou a utilizar apenas `Yes` e `No`, tornando os valores categóricos mais consistentes.

### Identificação e remoção de registros duplicados

Para identificar possíveis registros duplicados, foi utilizada uma CTE (*Common Table Expression*) em conjunto com `ROW_NUMBER()`.

Os registros foram agrupados por características como `ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate` e `LegalReference`. Dentro de cada grupo, `ROW_NUMBER()` atribuiu uma numeração aos registros, permitindo identificar como duplicados aqueles com valor superior a 1.

Antes da remoção, os registros identificados foram consultados utilizando `SELECT` para verificar o resultado. Em seguida, os registros duplicados foram removidos, mantendo uma única ocorrência de cada conjunto identificado.

### Separação dos endereços em diferentes colunas

Algumas informações de endereço estavam armazenadas em uma única coluna, dificultando o uso separado de elementos como endereço, cidade e estado.

Para `PropertyAddress`, foram utilizadas funções como `SUBSTRING` e `CHARINDEX` para separar o endereço da cidade a partir da posição do delimitador.

Já em `OwnerAddress`, foram utilizados `PARSENAME` e `REPLACE` para separar as informações em endereço, cidade e estado.

As informações resultantes foram armazenadas em novas colunas, deixando os dados mais estruturados para consultas e análises posteriores.

### Padronização da data de venda

A coluna `SaleDate` continha informações de data acompanhadas de horário, embora o horário não fosse necessário para o objetivo do projeto.

Foi criada uma nova coluna para armazenar a data em formato padronizado, utilizando `CONVERT` para transformar os valores para o tipo `DATE`.

Essa transformação deixou a informação de data mais adequada para consultas e análises posteriores.

### Resultado

Ao final do processo, a base ficou mais padronizada e estruturada, com endereços ausentes tratados, informações de endereço separadas em novas colunas, valores categóricos uniformizados e registros duplicados removidos.

O projeto permitiu praticar diferentes etapas de limpeza de dados com SQL Server, desde a identificação dos problemas até o teste das transformações antes de aplicá-las aos dados.

## Conceitos de SQL praticados

- `SELECT`
- `DISTINCT`
- `WHERE`
- `JOIN`
- `UPDATE`
- `ALTER TABLE`
- `CASE`
- `ISNULL`
- `CONVERT`
- `GROUP BY`
- `ORDER BY`
- `SUBSTRING`
- `CHARINDEX`
- `LEN`
- `REPLACE`
- `PARSENAME`
- `CTE`
- `PARTITION BY`
- `ROW_NUMBER()`

## Tecnologias

- SQL Server
- SQL Server Management Studio (SSMS)
- Visual Studio Code
- GitHub

## Estrutura

```text
NashvilleHousingSQL/
│
├── README.md
│
├── sql/
│   └── limpeza_nashville.sql
│
└── data/
    └── README.md
```

## Referência

Projeto baseado em uma aula/tutorial do **Alex The Analyst** sobre limpeza de dados utilizando SQL Server.

Tutorial utilizado: [Data Cleaning in SQL](https://www.youtube.com/watch?v=8rO7ztF4NtU)
