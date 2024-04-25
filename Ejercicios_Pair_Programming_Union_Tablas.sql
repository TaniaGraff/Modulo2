/* Ejercicio Pair Programming UNIÓN TABLAS.
*/

SELECT *
FROM northwind.products;

/* 1. Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos 
con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 
Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
*/

SELECT
customers.customer_id AS Identificador,
customers.company_name AS NombreEmpresa,
COUNT(orders.order_id) AS NumeroPedidos
FROM northwind.customers
LEFT JOIN northwind.orders 
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'
GROUP BY Identificador,
NombreEmpresa;

/* 2. Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición 
anterior y han decidido pedirnos una serie de consultas adicionales. 
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido
cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la 
empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
*/

SELECT 
customers.company_name AS NombreEmpresa,
YEAR(orders.order_date) AS Año,
SUM(order_details.quantity) AS CantidadProductosPedidos
FROM 
northwind.customers
LEFT JOIN northwind.orders 
ON customers.customer_id = orders.customer_id
LEFT JOIN northwind.order_details 
ON orders.order_id = order_details.order_id
WHERE customers.country = 'UK'
GROUP BY NombreEmpresa, Año;

/* 3. Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la 
cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los 
descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 
15% nos sale como 0.15.
*/

SELECT 
customers.company_name AS NombreEmpresa,
YEAR(orders.order_date) AS Año,
SUM(order_details.quantity) AS CantidadProductosPedidos,
SUM((order_details.unit_price * order_details.quantity) - (order_details.unit_price * order_details.quantity * order_details.discount)) AS DineroTotal
FROM northwind.customers
LEFT JOIN northwind.orders
ON customers.customer_id = orders.customer_id
LEFT JOIN northwind.order_details 
ON orders.order_id = order_details.order_id
WHERE customers.country = 'UK'
GROUP BY NombreEmpresa, Año;

/* 4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han 
obtenido, desde la central nos han pedido una consulta que indique el nombre de cada compañia 
cliente junto con cada pedido que han realizado y su fecha.
*/

SELECT 
orders.order_id AS IDPedido,
customers.company_name AS NombreEmpresa,
orders.order_date AS FechaPedido
FROM northwind.customers
LEFT JOIN northwind.orders
ON customers.customer_id = orders.customer_id
GROUP BY IDPedido, NombreEmpresa, FechaPedido;

/* 5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre 
de la categoría y el nombre del producto, y el total de dinero por el que se ha vendido cada 
tipo de producto (teniendo en cuenta los descuentos). 
*/

SELECT
products.category_id AS IDCategoria,
categories.category_name AS NombreCategoria,
products.product_name AS NombreProducto,
SUM((order_details.unit_price * order_details.quantity) - (order_details.unit_price * order_details.quantity * order_details.discount)) AS DineroTotal
FROM northwind.products
LEFT JOIN northwind.categories
ON products.category_id = categories.category_id
LEFT JOIN northwind.order_details
ON order_details. product_id = products.product_id
GROUP BY IDCategoria, NombreCategoria, NombreProducto
ORDER BY NombreCategoria ASC;

/* 6. Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas 
las empresas cliente, los ID de sus pedidos y las fechas.
*/

SELECT 
orders.order_id AS IDPedido,
customers.company_name AS NombreEmpresa,
orders.order_date AS FechaPedido
FROM northwind.customers
LEFT JOIN northwind.orders
ON orders.customer_id = customers.customer_id
GROUP BY IDPedido, NombreEmpresa, FechaPedido;

/* 7. Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos 
que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder 
adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente 
junto con el número de pedidos.
*/

SELECT
customers.company_name AS NombreEmpresa,
COUNT(orders.order_id) AS CantidadPedidos
FROM northwind.customers
LEFT JOIN northwind.orders
ON orders.customer_id = customers.customer_id
WHERE country = 'UK'
GROUP BY NombreEmpresa;

/* 8. Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido
(tengan pedidos o no) junto con los ID de todos los pedidos que han realizado y la fecha del 
pedido.
*/

SELECT 
orders.order_id AS IDPedido,
customers.company_name AS NombreEmpresa,
orders.order_date AS FechaPedido
FROM northwind.customers
LEFT JOIN northwind.orders
ON customers.customer_id = orders.customer_id
WHERE country = 'UK'
GROUP BY IDPedido, NombreEmpresa, FechaPedido;

/* 9. Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por
pantalla los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: 
la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
Investiga el resultado, ¿sabes decir quién es el director?
*/

SELECT
A.city AS CiudadEmpleado, 
A.first_name AS NombreEmpleado,
A.last_name AS ApellidoEmpleado,
B.city AS CiudadSupervisor,
B.first_name AS NombreSupervisor,
B.last_name AS ApellidoSupervisor
FROM northwind.employees AS A, northwind.employees AS B
WHERE A.reports_to = B.employee_id;

-- El director es Andrew Fuller: employee_id 2

/* 10. BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos 
asociados o no. Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido 
(si existe).
*/

SELECT
orders.order_id AS IDPedido,
customers.customer_id AS NombreCliente,
orders.order_date AS FechaPedido
FROM northwind.customers
LEFT JOIN northwind.orders
ON orders.customer_id = customers.customer_id
UNION
SELECT
orders.order_id AS IDPedido,
customers.customer_id AS NombreCliente,
orders.order_date AS FechaPedido
FROM northwind.customers
RIGHT JOIN northwind.orders
ON orders.customer_id = customers.customer_id
GROUP BY IDPedido, NombreCliente, FechaPedido;
