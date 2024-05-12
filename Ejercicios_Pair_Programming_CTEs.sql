/* Ejercicio Pair Programming CTE's.
*/

USE northwind;

/* -- Ejercicio 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la 
compañia de la tabla Customers.
*/

#SEUDOCÓDIGO:
#customers: customer_id, company_name

	WITH CustomersCTE AS(
		SELECT
        customer_id,
        company_name
        FROM customers
	)

SELECT *
FROM CustomersCTE;

/* -- Ejercicio 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, 
pero solo queremos los que pertezcan a "Germany".
*/
	WITH CustomersCTE AS(
		SELECT
        customer_id,
        company_name,
        country
        FROM customers
	)

SELECT *
FROM CustomersCTE
WHERE country = 'Germany';

/* -- Ejercicio 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia 
a la que pertenece. 📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, 
y Company Name).
*/

#SEUDOCÓDIGO:
#customers: customer_id, company_name
#orders: order_id, customer_id, order_date

	WITH CustomersCTE AS(
		SELECT
        customers.customer_id,
        customers.company_name,
        orders.order_id,
        orders.order_date
		FROM customers
        INNER JOIN orders
        ON customers.customer_id = orders.customer_id
	)
    
SELECT *
FROM CustomersCTE;

/* -- Ejercicio 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.
*/

	WITH CustomersCTE AS(
		SELECT
        customers.customer_id,
        customers.company_name,
        COUNT(DISTINCT orders.order_id)
        FROM customers
        INNER JOIN orders
        ON customers.customer_id = orders.customer_id
        GROUP BY customers.customer_id
	)

SELECT *
FROM CustomersCTE;

/* -- Ejercicio 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.
*/

#SEUDOCÓDIGO:
#products -> product_id, product_name
#order_details -> order_id, product_id, quantity

	WITH CantidadMediaProducto AS(
		SELECT
        products.product_id,
        products.product_name AS Producto,
        AVG(DISTINCT order_details.quantity) AS MediaPedidos
        FROM products
        INNER JOIN order_details
        ON products.product_id = order_details.product_id
        GROUP BY products.product_id
	)

SELECT 
product_id,
Producto,
MediaPedidos
FROM CantidadMediaProducto;

/* -- Ejercicio 6. Usando una CTE, extraer el nombre de las diferentes categorías de productos, 
con su precio medio, máximo y mínimo.
*/

#SEUDOCÓDIGO:
#products -> product_id, category_id, unit_price
#categories -> category_id, category_name

	WITH CategoriasProducto AS(
		SELECT 
        categories.category_id,
        categories.category_name,
        products.unit_price
        FROM categories
        INNER JOIN products
        ON categories.category_id = products.category_id
	)
    
SELECT 
category_name,
AVG(unit_price),
MAX(unit_price),
MIN(unit_price)
FROM CategoriasProducto
GROUP BY category_name;

/* -- Ejercicio 7. La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono 
y el número de pedidos que ha hecho cada uno de ellos. 
*/

#SEUDOCÓDIGO: 
#customers -> customer_id, company_name, phone
#orders -> order_id, customer_id

	WITH PedidosCliente AS(
		SELECT
		customers.customer_id,
        customers.company_name,
        customers.phone,
        COUNT(orders.order_id) AS num_pedidos
        FROM customers
        INNER JOIN orders
        ON customers.customer_id = orders.customer_id
        GROUP BY customers.customer_id
	)
    
SELECT
company_name,
phone,
num_pedidos
FROM PedidosCliente
ORDER BY num_pedidos;


/* -- Ejercicio 8. Modifica la consulta anterior para obtener los mismos resultados pero 
con los pedidos por año que ha hecho cada cliente.
*/

#SEUDOCÓDIGO: 
#customers -> customer_id, company_name, phone
#orders -> order_id, customer_id, order_date

	WITH PedidosCliente AS(
		SELECT
		customers.customer_id,
        customers.company_name,
        customers.phone,
		YEAR(orders.order_date) AS año_pedidos,
        COUNT(orders.order_id) AS num_pedidos
        FROM customers
        INNER JOIN orders
        ON customers.customer_id = orders.customer_id
        GROUP BY 
        customers.customer_id,
        customers.company_name,
        customers.phone,
		año_pedidos
	)

SELECT
company_name,
phone,
año_pedidos,
num_pedidos
FROM PedidosCliente
ORDER BY num_pedidos;

/* -- Ejercicio 9. Modifica la cte del ejercicio anterior, úsala en una subconsulta para 
saber el nombre del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 
pedidos en el año 1998.
*/

#SEUDOCÓDIGO: 
#customers -> customer_id, company_name, phone
#orders -> order_id, customer_id, order_date
#clientes que han hecho + de 6 pedidos en 1998.

	WITH PedidosCliente AS (
		SELECT
        customers.customer_id,
        customers.company_name,
        customers.phone,
        COUNT(orders.order_id) AS num_pedidos
		FROM customers
		INNER JOIN 
        orders ON customers.customer_id = orders.customer_id
		WHERE YEAR(orders.order_date) = 1998
		GROUP BY
        customers.customer_id,
        customers.company_name,
        customers.phone
)

SELECT
company_name,    
phone
FROM PedidosCliente
WHERE num_pedidos >= 6;

/* -- Ejercicio 10. 
Nos piden que obtengamos el importe total (teniendo en cuenta los descuentos) de cada pedido de la tabla orders 
y el customer_id asociado a cada pedido.
*/

#SEUDOCÓDIGO: 
#Pedidos por cliente -> orders -> order_id, customer_id
#Importe total de cada de cada pedido -> order_id, unit_price, quantity, discount


	WITH ImporteTotal AS(
		SELECT 
        orders.customer_id,
        (order_details.unit_price * order_details.quantity) - (order_details.unit_price * order_details.quantity * order_details.discount) AS precio_pedido
        FROM orders
        INNER JOIN order_details
        ON orders.order_id = order_details.order_id
        
	)
    
    SELECT
	customer_id,
	precio_pedido
	FROM ImporteTotal;

