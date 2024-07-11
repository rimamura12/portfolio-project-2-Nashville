SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [Portfolioproject1].[dbo].[NashvilleHousing]

  Select*
  from Portfolioproject1.dbo.NashvilleHousing
  
    --Standardize Data Formatting

  select saledateconverted, convert(date,saledate)
  from Portfolioproject1.dbo.NashvilleHousing

  update NashvilleHousing
  set saledate = convert(date,saledate)

  alter table nashvillehousing
  add saledateconverted date;

  update NashvilleHousing
  set saledateconverted = convert(date,saledate)

  --populate property address data

    select propertyAddress
  from Portfolioproject1.dbo.NashvilleHousing
  where propertyaddress is null

      select*
  from Portfolioproject1.dbo.NashvilleHousing
  where propertyaddress is null

       select*
  from Portfolioproject1.dbo.NashvilleHousing
  -- where propertyaddress is null
  order by ParcelID

        select*
  from Portfolioproject1.dbo.NashvilleHousing a
  join Portfolioproject1.dbo.NashvilleHousing b
  on a.ParcelID = b.ParcelID
  And a.[UniqueID ] <> b.[UniqueID ]

select a.ParcelID, a.PropertyAddress, b. ParcelID, b.PropertyAddress, isnull(a.propertyaddress,b.propertyaddress)
  from Portfolioproject1.dbo.NashvilleHousing a
  join Portfolioproject1.dbo.NashvilleHousing b
  on a.ParcelID = b.ParcelID
  And a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null

  update a
  set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
  from Portfolioproject1.dbo.NashvilleHousing a
  join Portfolioproject1.dbo.NashvilleHousing b
  on a.ParcelID = b.ParcelID
  And a.[UniqueID ] <> b.[UniqueID ]

  --Breaking Out Address into Individual Columns (Address, City, State)

  select PropertyAddress
  from Portfolioproject1.dbo.NashvilleHousing
  --where propertyaddres is null
  --order by ParcelID

  select 
  SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)) as address,
  charindex(',', propertyaddress)
  from Portfolioproject1.dbo.NashvilleHousing

  select 
  SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) as address
  from Portfolioproject1.dbo.NashvilleHousing

  select 
  SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) as address,
  SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1, LEN(propertyaddress)) as address
  from Portfolioproject1.dbo.NashvilleHousing

  alter table nashvillehousing
  add Propertysplitaddress Nvarchar(255);

  update NashvilleHousing
  set propertysplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1)

  alter table nashvillehousing
  add propertycity Nvarchar(255);

  update NashvilleHousing
  set propertycity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1, LEN(propertyaddress))

  alter table nashvillehousing
  drop column propertysplitcity

  alter table nashvillehousing
  drop column propertysplicity

  select*
  from Portfolioproject1.dbo.NashvilleHousing

  select OwnerAddress
  from Portfolioproject1.dbo.NashvilleHousing

  select 
  parsename(owneraddress, 1)
  from Portfolioproject1.dbo.NashvilleHousing

  select 
  parsename(replace(owneraddress,',','.'), 1),
  parsename(replace(owneraddress,',','.'), 2),
  parsename(replace(owneraddress,',','.'), 3)
  from Portfolioproject1.dbo.NashvilleHousing

  select 
  parsename(replace(owneraddress,',','.'), 3),
  parsename(replace(owneraddress,',','.'), 2),
  parsename(replace(owneraddress,',','.'), 1)
  from Portfolioproject1.dbo.NashvilleHousing

  alter table nashvillehousing
  add ownersplitaddress Nvarchar(255);

  update NashvilleHousing
  set ownersplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1)

  alter table nashvillehousing
  add ownercity Nvarchar(255);

  update NashvilleHousing
  set ownercity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1, LEN(propertyaddress))

  alter table nashvillehousing
  add ownerstate Nvarchar(255);

  update NashvilleHousing
  set ownerstate = parsename(replace(owneraddress,',','.'), 1)


  select*
  from Portfolioproject1.dbo.NashvilleHousing

  --change Y and N to Yes and No in "Sold as Vacant" field

  select distinct (SoldAsVacant)
  from Portfolioproject1.dbo.NashvilleHousing

  select distinct (SoldAsVacant), count(soldasvacant)
  from Portfolioproject1.dbo.NashvilleHousing
  group by soldasvacant
  order by 2

  select SoldAsVacant,
  case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end
  from Portfolioproject1.dbo.NashvilleHousing

  update NashvilleHousing
  set SoldAsVacant =   case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end

--remove duplicates

   select*
  from Portfolioproject1.dbo.NashvilleHousing

select*,
row_number() over (
partition by parcelID, propertyaddress, saleprice, saledate, legalreference
order by uniqueID) row_number
 from Portfolioproject1.dbo.NashvilleHousing
 order by ParcelID

 with rownumcte as(
 select*,
row_number() over (
partition by parcelID, propertyaddress, saleprice, saledate, legalreference
order by uniqueID) row_number
 from Portfolioproject1.dbo.NashvilleHousing
 --order by ParcelID
 )

 select*
 from rownumcte
 where row_number > 1
 order by PropertyAddress

  with rownumcte as(
 select*,
row_number() over (
partition by parcelID, propertyaddress, saleprice, saledate, legalreference
order by uniqueID) row_number
 from Portfolioproject1.dbo.NashvilleHousing
 --order by ParcelID
 )

 delete
 from rownumcte
 where row_number > 1
 --order by PropertyAddress

  with rownumcte as(
 select*,
row_number() over (
partition by parcelID, propertyaddress, saleprice, saledate, legalreference
order by uniqueID) row_number
 from Portfolioproject1.dbo.NashvilleHousing
 --order by ParcelID
 )

 select*
 from rownumcte
 where row_number > 1
 order by PropertyAddress

 --delete unused columns

   select*
  from Portfolioproject1.dbo.NashvilleHousing

  alter table Portfolioproject1.dbo.NashvilleHousing
  drop column owneraddress, taxdistrict, propertyaddress

     select*
  from Portfolioproject1.dbo.NashvilleHousing