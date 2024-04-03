CREATE SCHEMA til_portfolio_projects.Asha_schema;


-- LEGO COLOURS ---
CREATE or REPLACE TABLE Asha_schema.LEGO_COLORS(
	ID NUMBER(4,0),
	NAME VARCHAR(28),
	RGB VARCHAR(6),
	IS_TRANS VARCHAR(1)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_COLORS (
SELECT *
FROM til_portfolio_projects.staging.LEGO_COLORS
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(ID)), MAX(LENGTH(NAME)), MAX(LENGTH(RGB)), MAX(LENGTH(IS_TRANS))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_COLORS;


-- LEGO INVENTORIES ---
CREATE or REPLACE TABLE Asha_schema.LEGO_INVENTORIES(
	ID NUMBER(5,0),
	VERSION NUMBER(1,0),
	SET_NUM VARCHAR(16)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_INVENTORIES (
SELECT *
FROM til_portfolio_projects.staging.LEGO_INVENTORIES
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(ID)), MAX(LENGTH(VERSION)), MAX(LENGTH(SET_NUM))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_INVENTORIES;


-- LEGO INVENTORY_PARTS ---
CREATE or REPLACE TABLE Asha_schema.LEGO_INVENTORY_PARTS(
    INVENTORY_ID NUMBER(5,0),
	PART_NUM VARCHAR(15),
	COLOR_ID NUMBER(4,0),
	QUANTITY NUMBER(4,0),
	IS_SPARE VARCHAR(1)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_INVENTORY_PARTS (
SELECT *
FROM til_portfolio_projects.staging.LEGO_INVENTORY_PARTS
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(INVENTORY_ID)), MAX(LENGTH(PART_NUM)), MAX(LENGTH(COLOR_ID))
, MAX(LENGTH(QUANTITY)), MAX(LENGTH(IS_SPARE))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_INVENTORY_PARTS;

-- LEGO INVENTORY_SETS ---
CREATE or REPLACE TABLE Asha_schema.LEGO_INVENTORY_SETS(
    INVENTORY_ID NUMBER(5,0),
	SET_NUM VARCHAR(16),
	QUANTITY NUMBER(2,0)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_INVENTORY_SETS (
SELECT *
FROM til_portfolio_projects.staging.LEGO_INVENTORY_SETS
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(INVENTORY_ID)), MAX(LENGTH(SET_NUM)), MAX(LENGTH(QUANTITY))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_INVENTORY_SETS;


-- LEGO PARTS ---
CREATE or REPLACE TABLE Asha_schema.LEGO_PARTS(
    PART_NUM VARCHAR(15),
	NAME VARCHAR(223),
	PART_CAT_ID NUMBER(2,0)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_PARTS (
SELECT *
FROM til_portfolio_projects.staging.LEGO_PARTS
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(PART_NUM)), MAX(LENGTH(NAME)), MAX(LENGTH(PART_CAT_ID))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_PARTS;


-- LEGO PARTS CATEGORIES ---
CREATE or REPLACE TABLE Asha_schema.LEGO_PARTS_CATEGORIES(
	ID NUMBER(2,0),
	NAME VARCHAR(44)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_PARTS_CATEGORIES (
SELECT *
FROM til_portfolio_projects.staging.LEGO_PART_CATEGORIES
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(ID)), MAX(LENGTH(NAME))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_PARTS_CATEGORIES;


-- LEGO SETS ---
CREATE or REPLACE TABLE Asha_schema.LEGO_SETS(
    SET_NUM VARCHAR(16),
	NAME VARCHAR(95),
	YEAR NUMBER(4,0),
	THEME_ID NUMBER(3,0),
	NUM_PARTS NUMBER(4,0)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_SETS (
SELECT *
FROM til_portfolio_projects.staging.LEGO_SETS
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(SET_NUM)), MAX(LENGTH(NAME)), MAX(LENGTH(YEAR)), MAX(LENGTH(THEME_ID)),
MAX(LENGTH(NUM_PARTS))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_SETS;

-- LEGO THEMES ---
CREATE or REPLACE TABLE Asha_schema.LEGO_THEMES(
    ID NUMBER(3,0),
	NAME VARCHAR(32),
	PARENT_ID NUMBER(3,0)
);

INSERT INTO til_portfolio_projects.Asha_schema.LEGO_THEMES (
SELECT *
FROM til_portfolio_projects.staging.LEGO_THEMES
);

-- Check column character length, for varchar() length
SELECT MAX(LENGTH(ID)), MAX(LENGTH(NAME)), MAX(LENGTH(PARENT_ID))
FROM TIL_PORTFOLIO_PROJECTS.Asha_schema.LEGO_THEMES;

--- KEYS ---

ALTER TABLE LEGO_COLORS ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_INVENTORIES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_SETS ADD PRIMARY KEY (SET_NUM);
ALTER TABLE LEGO_PARTS ADD PRIMARY KEY (PART_NUM);
ALTER TABLE LEGO_THEMES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_PARTS_CATEGORIES ADD PRIMARY KEY (ID);

ALTER TABLE LEGO_INVENTORIES ADD FOREIGN KEY (set_num) REFERENCES LEGO_SETS(set_num);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (part_num) REFERENCES LEGO_PARTS(part_num);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (color_id) REFERENCES LEGO_COLORS(id);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (inventory_id) REFERENCES LEGO_INVENTORIES(id);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (inventory_id) REFERENCES LEGO_INVENTORIES(id);
ALTER TABLE LEGO_INVENTORY_SETS ADD FOREIGN KEY (inventory_id) REFERENCES LEGO_INVENTORIES(id);
ALTER TABLE LEGO_INVENTORY_SETS ADD FOREIGN KEY (set_num) REFERENCES LEGO_SETS(set_num);
ALTER TABLE LEGO_PARTS ADD FOREIGN KEY (part_cat_id) REFERENCES LEGO_PARTS_CATEGORIES(id);
ALTER TABLE LEGO_SETS ADD FOREIGN KEY (theme_id) REFERENCES LEGO_THEMES(id);
