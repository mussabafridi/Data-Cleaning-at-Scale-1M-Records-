select *
from [sql work].dbo.Nash
--where PropertyAddress is null
order by ParcelID;

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [sql work].dbo.Nash a
JOIN [sql work].dbo.Nash b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [sql work].dbo.Nash a
JOIN [sql work].dbo.Nash b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;


select * 
from [sql work].dbo.Nash




select PropertyAddress
from [sql work].dbo.Nash;

select 
substring(PropertyAddress, 1, charindex(',', PropertyAddress) - 1) as Address
,substring(PropertyAddress,charindex(',', PropertyAddress) + 1, len(PropertyAddress)) as Address
from [sql work].dbo.Nash


alter table [sql work].dbo.Nash
add PropertyAddress2 varchar(255);

update [sql work].dbo.Nash
set PropertyAddress2 = substring(PropertyAddress, 1, charindex(',', PropertyAddress) - 1)

alter table [sql work].dbo.Nash
add PropertyCityAddress varchar(255);

update [sql work].dbo.Nash	
set PropertyCityAddress = substring(PropertyAddress,charindex(',', PropertyAddress) + 1, len(PropertyAddress))


select PropertyAddress2, PropertyCityAddress
from [sql work].dbo.Nash;


select OwnerAddress
from [sql work].dbo.Nash;

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerStreetAddress
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) as OwnerCity
	,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) as OwnerState
	from [sql work].dbo.Nash;


alter table [sql work].dbo.Nash
add OwnerStreetAddress varchar(255);

update [sql work].dbo.Nash
set OwnerStreetAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) 

alter table [sql work].dbo.Nash
add OwnerCity varchar(255);

update [sql work].dbo.Nash
set OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) 

alter table [sql work].dbo.Nash
add OwnerState varchar(255);

update [sql work].dbo.Nash
set OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


select OwnerStreetAddress, OwnerCity, OwnerState
from [sql work].dbo.Nash;

select *
from [sql work].dbo.Nash

select SoldAsVacant
,CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
    END 
from [sql work].dbo.Nash;

update [sql work].dbo.Nash
set SoldAsVacant = CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END	;


select distinct (SoldAsVacant), count(SoldAsVacant)
from [sql work].dbo.Nash
group by SoldAsVacant
order by 2;




WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [sql work].dbo.Nash
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress
;




WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [sql work].dbo.Nash
)
delete
From RowNumCTE
Where row_num > 1




select *
from [sql work].dbo.Nash;


alter table [sql work].dbo.Nash
drop column OwnerAddress,propertyAddress,Taxdistrict,SaleDate;