USE sakila; 
-- Ejercicio 1
SELECT * FROM actor
WHERE first_name LIKE 'A%';

-- Ejercicio 2
SELECT
	actor_id,
	first_name,
	last_name,
    CONCAT(first_name, last_name) AS full_name
FROM actor
WHERE first_name LIKE 'A%';

-- Ejercicio 3
SELECT
	actor_id,
	first_name,
	last_name,
	CONCAT(first_name, last_name) AS full_name,
    CHARACTER_LENGTH(CONCAT(first_name, last_name)) AS name_length
FROM actor
WHERE first_name LIKE 'A%';

-- Ejercicio 4
SELECT
	actor_id,
	-- REPLACE(LOWER(first_name), SUBSTRING(LOWER(first_name), 1, 1), UPPER(SUBSTRING(LOWER(first_name), 1, 1))),
	CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name,
	CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))) AS last_name,
    CONCAT(first_name, last_name) AS full_name,
    CHARACTER_LENGTH(CONCAT(first_name, last_name)) AS name_length
FROM actor
WHERE first_name LIKE 'A%';

-- Ejercicio 5
SELECT
	actor_id,
	CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name,
	CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))) AS last_name,
    CONCAT(first_name, last_name) AS full_name,
    CHARACTER_LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length
FROM actor
WHERE first_name LIKE 'A%'
HAVING name_length > 10;

-- Ejercicio 6
SELECT
	actor_id,
	CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name,
	CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))) AS last_name,
    CONCAT(first_name, last_name) AS full_name,
    CHARACTER_LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length,
    YEAR(last_update) AS registration_year
FROM actor
WHERE first_name LIKE 'A%'
HAVING name_length > 10;

-- Ejercicio 7
SELECT
	last_name,
	COUNT(actor_id) AS total_actors
FROM actor
WHERE first_name LIKE 'A%'
	AND CHARACTER_LENGTH(CONCAT(first_name, ' ', last_name)) > 10
GROUP BY (last_name);

-- Ejercicio 8
SELECT
	actor_id,
	CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name,
	CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))) AS last_name,
	last_update,
	CONCAT(first_name, last_name) AS full_name,
	CHARACTER_LENGTH(CONCAT(first_name, last_name)) AS name_length,
    YEAR(last_update) AS registration_year,
    CASE
    	WHEN COUNT(*) OVER (PARTITION BY CONCAT(first_name, ' ', last_name)) = 1 THEN TRUE
    	ELSE FALSE
    END AS is_unique_name   
FROM actor
WHERE first_name LIKE 'A%'
	AND CHARACTER_LENGTH(CONCAT(first_name, ' ', last_name)) > 10;


-- Ejercicio 9
SELECT
	actor_id,
	CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))) AS first_name,
	CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))) AS last_name,
	last_update,
	CONCAT(first_name, last_name) AS full_name,
	CHARACTER_LENGTH(CONCAT(first_name, last_name)) AS name_length,
    YEAR(last_update) AS registration_year,
    CASE
    	WHEN COUNT(*) OVER (PARTITION BY CONCAT(first_name, ' ', last_name)) = 1 THEN TRUE
    	ELSE FALSE
    END AS is_unique_name,
    CASE 
    	WHEN actor_id > 10 THEN 'Active'
    	ELSE 'Inactive'
    END AS actor_status
FROM actor
WHERE first_name LIKE 'A%'
	AND CHARACTER_LENGTH(CONCAT(first_name, ' ', last_name)) > 10;