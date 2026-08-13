# Nashville Housing - Limpeza de Dados com SQL

Projeto de estudo desenvolvido para praticar **SQL Server** e conceitos básicos de limpeza e transformação de dados.

## Sobre o projeto

Neste projeto utilizei a base Nashville Housing para praticar tarefas comuns de preparação de dados antes de uma análise.

O objetivo principal foi identificar problemas nos dados e aplicar transformações utilizando SQL.

## Principais etapas

* Inspeção inicial dos dados;
* Padronização do formato de datas;
* Preenchimento de valores nulos em `PropertyAddress`;
* Separação de endereço e cidade;
* Separação do endereço do proprietário em endereço, cidade e estado;
* Padronização dos valores de `SoldAsVacant`;
* Identificação e remoção de registros duplicados;
* Remoção de colunas que deixaram de ser necessárias após a transformação.

## Conceitos de SQL praticados

Durante o projeto foram utilizados:

* `SELECT`
* `WHERE`
* `JOIN`
* `UPDATE`
* `ALTER TABLE`
* `CASE`
* `ISNULL`
* `GROUP BY`
* `ORDER BY`
* `SUBSTRING`
* `CHARINDEX`
* `LEN`
* `REPLACE`
* `PARSENAME`
* `CTE`
* `ROW_NUMBER()`

## Tecnologias

* SQL Server
* SQL Server Management Studio (SSMS)
* Visual Studio Code
* Git
* GitHub

## Estrutura

```text
nashville-housing-sql/
│
├── README.md
│
├── sql/
│   └── limpeza_nashville_housing.sql
│
└── data/
    └── README.md
```

## Aprendizados

O projeto foi utilizado como exercício prático para desenvolver familiaridade com SQL Server, principalmente com manipulação de dados, valores nulos, `JOINs`, funções de texto, CTEs e identificação de registros duplicados.

Este repositório faz parte dos meus estudos em SQL e análise de dados.
