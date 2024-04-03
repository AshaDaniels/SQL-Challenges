# SQL-Challenges
 Here are my solutions

![Lego Schema](https://github.com/AshaDaniels/SQL-Challenges/blob/main/Lego%20Project/Lego%20Schema.png?raw=true)

## Part 1: Schema Setup
```
CREATE SCHEMA til_portfolio_projects.Asha_schema;
```

## Part 2: Table Creation

```
-- LEGO COLORS table
CREATE TABLE Asha_schema.LEGO_COLORS(
    ID NUMBER(4,0),
    NAME VARCHAR(28),
    RGB VARCHAR(6),
    IS_TRANS VARCHAR(1)
);
```
I then created the other tables: LEGO_INVENTORIES, LEGO_INVENTORY_PARTS, LEGO_INVENTORY_SETS, LEGO_PARTS, LEGO_PARTS_CATEGORIES, LEGO_SETS, 

## Part 3: Data Insertion:

```
-- Insert data into LEGO_COLORS table from staging
INSERT INTO til_portfolio_projects.Asha_schema.LEGO_COLORS
SELECT * FROM til_portfolio_projects.staging.LEGO_COLORS;
```

This was repeated for other tables: LEGO_INVENTORIES, LEGO_INVENTORY_PARTS, LEGO_INVENTORY_SETS, LEGO_PARTS, LEGO_PARTS_CATEGORIES, LEGO_SETS, LEGO_THEMES

## Part 4: Field Size Optimisation:
```
-- Check column character lengths for LEGO_COLORS table
SELECT MAX(LENGTH(ID)), MAX(LENGTH(NAME)), MAX(LENGTH(RGB)), MAX(LENGTH(IS_TRANS))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_COLORS;
```

I repeated for other tables: LEGO_INVENTORIES, LEGO_INVENTORY_PARTS, LEGO_INVENTORY_SETS, LEGO_PARTS, LEGO_PARTS_CATEGORIES, LEGO_SETS, LEGO_THEMES
Here, the SELECT MAX(LENGTH(...)) statement is used to check the maximum character length of each column in the tables.

## Part 5: Keys Definition:
```
-- Add primary keys and foreign keys to tables
ALTER TABLE LEGO_COLORS ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_INVENTORIES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_SETS ADD PRIMARY KEY (SET_NUM);
```
Add foreign keys to other tables

