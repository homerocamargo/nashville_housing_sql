--Selecionar todas colunas pra uma rápida inspeção visual

USE [Nashville Housing];
select * from dbo.NashvilleHousing;


-- Padronizar o SaleDate ao remover o horário  (2014-06-11 00:00:00.000 --> 2014-06-11)

SELECT
    SaleDate,
    CONVERT(date, SaleDate) AS SaleDateConverted
FROM dbo.NashvilleHousing;

alter table dbo.NashvilleHousing -- adicionar nova coluna pra converter o formato de data
add SaleDateConverted date;

Update dbo.NashvilleHousing
SET SaleDateConverted = convert(date, SaleDate)


-- Popular a coluna do PropertyAddress pra preencher em campos NULL usando PareclID como referência

select *
from dbo.NashvilleHousing
order by ParcelID

select t1.ParcelID, t1.PropertyAddress,t2.ParcelID, t2.PropertyAddress -- pra testar se o join está funcionando como esperado
from dbo.NashvilleHousing as t1
join dbo.NashvilleHousing as t2
on t1.ParcelID = t2.ParcelID and t1.[UniqueID ] <> t2.[UniqueID ]
where t1.PropertyAddress is null

update t1 -- atualizando t1 usando a função ISNULL
set PropertyAddress = isnull(t1.PropertyAddress,t2.PropertyAddress)
from dbo.NashvilleHousing as t1
join dbo.NashvilleHousing as t2
on t1.ParcelID = t2.ParcelID and t1.[UniqueID ] <> t2.[UniqueID ]
where t1.PropertyAddress is null


-- Dividindo PropertyAdress em diferentes colunas (Endereço, cidade, etc)

select -- substring e charindex pra manipular endereço da string. A query nos deixa ver se temos os resultados esperados.
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as City 
from dbo.NashvilleHousing

alter table dbo.NashvilleHousing -- adicionar nova coluna pro Property Address
add PropertySplitAddress nvarchar(255);

Update dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

alter table dbo.NashvilleHousing -- Adicionar nova coluna pro Property City
add PropertySplitCity nvarchar(255);

Update dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))


-- Dividindo o OwnerAddress em diferentes colunas (Address, City, State)

select -- using PARSENAME. PARSENAME only recognises '.' so we have to replace ',' in string to '.' and it starts reading the string backwards.
	PARSENAME(replace(OwnerAddress, ',','.'),1),
	PARSENAME(replace(OwnerAddress, ',','.'),2),
	PARSENAME(replace(OwnerAddress, ',','.'),3)
from dbo.NashvilleHousing

alter table dbo.NashvilleHousing -- adicionando nova coluna pro Owner Address
add OwnerSplitAddress nvarchar(255);

Update dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(replace(OwnerAddress, ',','.'),3)

alter table dbo.NashvilleHousing -- adicionando nova coluna pro Owner City
add OwnerSplitCity nvarchar(255);

Update dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(replace(OwnerAddress, ',','.'),2)

alter table dbo.NashvilleHousing -- adicionar nova coluna pro Owner State
add OwnerSplitState nvarchar(255);

Update dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(replace(OwnerAddress, ',','.'),1)


-- Atualizando coluna do SoldAsVacant pra ter só "Yes" e "No"

select distinct SoldAsVacant,COUNT(SoldAsVacant) -- pra checar quais são as diferentes entradas pra coluna inicialmente
from dbo.NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant, -- usando CASE pra mudar entradas pra deixá-las uniformes (sem atualizar a tabela, só pra ajudar na checagem dos resultados e ver se são os esperados)
	case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end as newSoldAsVacant
from dbo.NashvilleHousing

Update dbo.NashvilleHousing -- Padronizar os valores Y e N para Yes e No
SET SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
						when SoldAsVacant = 'N' then 'No'
						else SoldAsVacant
						end


-- Identificar e remover registros duplicados
with NumerarDuplicados as(
select *,
	ROW_NUMBER() over (
	partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by
					UniqueID
				 ) as row_num
from dbo.NashvilleHousing
)
DELETE
from NumerarDuplicados
where row_num > 1 --Se row_num for maior que 1, o registro é considerado duplicado

-- Verificar a quantidade de registros após a limpeza

SELECT COUNT(*) AS TotalRegistros
FROM dbo.NashvilleHousing;

-- Deletas colunas que não foram mexidas ou usadas

alter table dbo.NashvilleHousing
drop column PropertyAddress, OwnerAddress, SaleDate -- Colunas que foram limpadas anteriormente

-- Verificação final

SELECT *
FROM dbo.NashvilleHousing;

SELECT COUNT(*) AS TotalRegistros
FROM dbo.NashvilleHousing;