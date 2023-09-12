# Nashville Housing Data Cleaning

This project cleans and prepares the Nashville Housing dataset for analysis. The raw dataset contains issues that need to be resolved including:

-- Inconsistent date formats

-- Null property address values

-- Messy address columns split across multiple fields

-- 'Y'/'N' sold as vacant values instead of 'Yes'/'No'

Duplicate rows


#### Tools Used:

-- MySQL

-- Datagrip

#### Data Cleaning Steps

-- The main data cleaning steps include:

-- Standardizing SaleDate format

-- Populating null PropertyAddress values using self-join

-- Splitting address into individual columns using SUBSTRING_INDEX and PARSENAME

-- Converting 'Y'/'N' to 'Yes'/'No' for SoldAsVacant using CASE statement

-- Removing duplicates using ROW_NUMBER() window function

-- Dropping unused columns not needed for analysis


#### Results
-- The cleaned Nashville Housing dataset contains:

-- Standardized data formats

-- No nulls for PropertyAddress

-- Split address columns for property and owner

-- Easy to understand SoldAsVacant values

-- No duplicate rows

-- Only columns that will be used for analysis


##### The dataset is now cleaned and ready for exploration and visualization. The cleaning steps applied provide a template that can be reused on other housing datasets as well.

