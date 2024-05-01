/* Ejercicio Pair Programming SUBCONSULTAS.
*/

SELECT *
FROM northwind.products;

/*
-- 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada. 
*/

SELECT 
order_id,
customer_id,
employee_id,
order_date,
required_date
FROM northwind.orders AS t1
WHERE order_date >= (
	SELECT
	MAX(order_date)
    FROM northwind.orders AS t2
    WHERE t1.employee_id = t2.employee_id);
    
/*
-- 2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario.
De nuevo lo tendréis que hacer con queries correlacionadas.
*/

SELECT
DISTINCT product_id,
unit_price
FROM northwind.order_details AS t1
WHERE t1.unit_price = (
	SELECT MAX(unit_price)
    FROM northwind.order_details AS t2
	WHERE t1.product_id = t2.product_id)
    ORDER BY product_id;

/*
-- 3. Extraed información de los productos "Beverages".
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para 
identificar un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". 
Devuelve el ID del producto, el nombre del producto y su ID de categoría.
*/

SELECT
product_id,
product_name,
category_id
FROM northwind.products
WHERE category_id IN (
	SELECT category_id
    FROM northwind.categories
    WHERE category_name = 'Beverages');
    
/*
-- 4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países
para buscar proveedores adicionales.
*/

SELECT
DISTINCT country
FROM northwind.customers
WHERE country NOT IN(
	SELECT country
    FROM northwind.suppliers);
    
/*
-- 5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread".
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
"Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.
*/

SELECT
order_id,
customer_id
FROM northwind.orders
WHERE order_id IN (
	SELECT order_id
    FROM northwind.order_details
    WHERE product_id = 6
	GROUP BY order_id
	HAVING SUM(quantity) > 20); 

/*
-- 6. Extraed los 10 productos más caros.
Nos siguen pidiendo más queries correlacionadas. 
En este caso queremos saber cuáles son los 10 productos más caros.
*/

SELECT
product_name AS Productos_Mas_Caros,
unit_price AS Precio_Unitario
FROM northwind.products
ORDER BY unit_price DESC
LIMIT 10;

/*
-- 7. Qué producto es más popular.
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
*/

    