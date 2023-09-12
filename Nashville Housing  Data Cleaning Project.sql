
/* Cleaning the Nashville Housing Data */

## MYSQL & DATAGRIP WAS USED FOR THIS PROJECT

select * from  Nashville;


# Standardize Date Format

select SaleDate from Nashville;


# Populate Property Address data' (using a self join)
select * from Nashville
where PropertyAddress is null
order by ParcelID;



select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,isnull(a.PropertyAddress, b.PropertyAddress)
from Nashville a
join Nashville b
on a.ParcelID=b.ParcelID
and a.UniqueID<> b.UniqueID
where a.PropertyAddress is NULL;

update a
set propertyaddress= isnull(a.PropertyAddress, b.PropertyAddress)
from ` Nashville Housing Data for Data Cleaning (reuploaded)` a
join `Nashville Housing Data for Data Cleaning (reuploaded)`b
on a.ParcelID=b.ParcelID
and a.UniqueID<> b.UniqueID
where a.PropertyAddress is NULL;



# Breaking out Address into Individual columns (Address, city, State)
select PropertyAddress
from Nashville;


select substring_index(PropertyAddress, 1, charindex(',', PropertyAddress)-1) as address
from  Nashville;


select substring_index(PropertyAddress, 1, charindex(',', PropertyAddress))                           as address,
       substring_index(PropertyAddress, charindex(',', PropertyAddress) + 1, length(PropertyAddress)) as address,
from Nashville;


Alter table Nashville
add PropertySplitAddress nvarchar(255);

update Nashville
set  PropertySplitAddress= substring_index(PropertyAddress, 1, charindex(',', PropertyAddress)-1);


alter table Nashville
set PropertySplitCity nvarchar(255);

update  Nashville
set PropertySplitCity= substring_index(PropertyAddress, charindex(',', PropertyAddress) + 1, length(PropertyAddress));


--- parsename is a easier method than substring



Select *
From Nashville;



Select OwnerAddress
From Nashville;


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Nashville;



Alter table Nashville
add OwnerSplitAddress nvarchar(255);

update Nashville
set  OwnerSplitAddress= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3);

Alter table Nashville
add OwnerSplitCity nvarchar(255);

update Nashville
set  OwnerSplitCity= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2);



Alter table Nashville
add OwnerSplitState nvarchar(255);

update Nashville
set  OwnerSplitState= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1);



# Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(SoldAsVacant), count(SoldAsVacant)
from Nashville
group by SoldAsVacant
order by 2;

select  SoldAsVacant,
        case when SoldAsVacant='y' then 'Yes'
             when SoldAsVacant='N' then 'No'
else SoldAsVacant
End
from Nashville;


update Nashville
set SoldAsVacant= case when SoldAsVacant='y' then 'Yes'
             when SoldAsVacant='N' then 'No'
else SoldAsVacant
End;


#   Remove Duplicates
with RowNumCTE as(
select *, row_number() over (partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference order by UniqueID ) as row_num
from Nashville
order by ParcelID)
delete from RowNumCTE
where row_num>1;



with RowNumCTE as(
select *, row_number() over (partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference order by UniqueID ) as row_num
from Nashville
order by ParcelID)
select * from RowNumCTE
where row_num>1
order by PropertyAddress;



#  Delete Unused Columns

select * from Nashville;

alter table  Nashville
drop column OwnerAddress;

alter table  Nashville
drop column TaxDistrict;

alter table  Nashville
drop column PropertyAddress;

alter table  Nashville
drop column SaleDate;
