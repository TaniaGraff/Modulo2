/* Ejercicio Pair Programming OPERADORES ESPECIALES DE FILTRO.
*/

SELECT *
FROM northwind.products;

/* Para esta práctica te hara falta crear en algunos de los ejercicios una columna temporal. 
Para ver como funciona esta creación de columnas temporales prueba el siguiente código:
*/

SELECT  'Hola!'  AS tipo_nombre
FROM northwind.customers;

/*
-- 1. Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias 
que están afincadas en ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, 
el nombre de la compañia y el nombre de contacto.
*/

SELECT
city AS 'Ciudad Clientes',
company_name AS 'Nombre Compañía',
contact_name AS 'Nombre Contacto'
FROM northwind.customers
WHERE city LIKE 'A%' OR city LIKE 'B%';

/*
-- 2. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total 
de pedidos que han hecho todas las ciudades que empiezan por "L".
*/

SELECT
customers.city AS 'Ciudad',
customers.company_name AS 'Nombre Compañia',
customers.contact_name AS 'Nombre Contacto',
COUNT(orders.order_id) AS 'Total Pedidos'
FROM northwind.customers 
LEFT JOIN northwind.orders 
ON customers.customer_id = orders.customer_id
WHERE customers.city LIKE 'L%'
GROUP BY customers.city, customers.company_name, customers.contact_name
ORDER BY customers.company_name;

/*
-- 3. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posición (contact_title) y el nombre de la compañia.
*/

SELECT
contact_name AS 'Nombre Contacto',
contact_title AS 'Titulo Contacto',
company_name AS 'Nombre Compañia'
FROM northwind.customers
WHERE contact_title NOT LIKE '%Sales%';

/*
-- 4.  Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.
*/

SELECT
contact_name AS 'Nombre Contacto'
FROM northwind.customers
WHERE contact_name NOT LIKE '_a%'
ORDER BY contact_name;

/*
-- 5. Extraer toda la información sobre las compañias que tengamos en la BBDD.
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos 
en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la 
relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship 
no existe y debe ser creada como columna temporal. Para ello añade el valor que le quieras dar al campo y utilizada 
como alias Relationship. Nota: Deberás crear esta columna temporal en cada instrucción SELECT.
*/

SELECT
company_name AS 'Nombre Compañia',
contact_name AS 'Nombre Contacto',
city AS Ciudad,
'Cliente' AS Relationship
FROM northwind.customers
UNION
SELECT
company_name AS 'Nombre Compañia',
contact_name AS 'Nombre Contacto',
city AS Ciudad,
'Proveedor' AS Relationship
FROM northwind.suppliers
ORDER BY Ciudad;

/*
-- 6.  Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".
*/

SELECT
category_name AS 'Nombre Categoria',
description AS 'Descripcion'
FROM northwind.categories
WHERE description LIKE '%sweet%' OR description LIKE '%Sweet%';

/*
-- 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD.
Pista. ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando 
concat para unir dos columnas.
*/

SELECT
CONCAT(first_name, ' ',  last_name) AS 'Nombre y Apellidos Empleados'
FROM northwind.employees
UNION ALL
SELECT
contact_name AS 'Nombre y Apellidos Clientes'
FROM northwind.customers;

