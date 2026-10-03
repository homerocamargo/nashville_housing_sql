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

## Conceitos de SQL praticados

- `SELECT`
- `WHERE`
- `JOIN`
- `UPDATE`
- `ALTER TABLE`
- `CASE`
- `ISNULL`
- `GROUP BY`
- `ORDER BY`
- `SUBSTRING`
- `CHARINDEX`
- `LEN`
- `REPLACE`
- `PARSENAME`
- `CTE`
- `ROW_NUMBER()`

## Tecnologias

- SQL Server
- SQL Server Management Studio (SSMS)
- Visual Studio Code
- GitHub

## O que estou praticando

Este é um projeto de estudo e faz parte do meu aprendizado de SQL.

O objetivo não é apresentar o projeto como algo desenvolvido inteiramente do zero, mas registrar minha prática e meu progresso enquanto aprendo SQL Server e limpeza de dados.

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

Projeto baseado em uma aula/tutorial do Alex The Analyst sobre limpeza de dados utilizando SQL Server.
