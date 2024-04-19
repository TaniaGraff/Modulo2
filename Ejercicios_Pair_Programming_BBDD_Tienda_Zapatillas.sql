 /*
 -- Ejercicios Pair Programming CREACIÓN BBDD.
 Crearemos 4 tablas en la BBDD: Empleados, Clientes, Facturas y Zapatillas.
 La tabla Facturas tiene una relación con la tabla Empleados y la tabla Clientes y la tabla Zapatillas. 
 Estas tres últimas no tienen ninguna relación entre ellas.
 */
 
CREATE SCHEMA tienda_zapatillas_Pair_Programming;
USE tienda_zapatillas_Pair_Programming;

CREATE TABLE Zapatillas (
Id_zapatillas INT NOT NULL AUTO_INCREMENT,
Modelo VARCHAR(45) NOT NULL,
Color VARCHAR(45) NOT NULL,
PRIMARY KEY (Id_zapatillas)
);

CREATE TABLE Clientes (
Id_cliente INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(45) NOT NULL,
Numero_telefono INT NOT NULL,
Email VARCHAR(45) NOT NULL,
Direccion VARCHAR(45) NOT NULL,
Ciudad VARCHAR(45),
Provincia VARCHAR(45) NOT NULL,
Pais VARCHAR(45) NOT NULL,
Codigo_postal VARCHAR(45) NOT NULL,
PRIMARY KEY (Id_cliente)
);

CREATE TABLE Empleados (
Id_empleado INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(45) NOT NULL,
Tienda VARCHAR(45) NOT NULL,
Salario FLOAT NULL, 
Fecha_incorporacion DATE NOT NULL,
PRIMARY KEY (Id_empleado)
);

CREATE TABLE Facturas (
Id_factura INT NOT NULL AUTO_INCREMENT,
Numero_factura VARCHAR(45) NOT NULL,
Fecha DATE NOT NULL,
Id_zapatillas INT NOT NULL,
Id_empleado INT NOT NULL,
Id_cliente INT NOT NULL,
PRIMARY KEY (Id_factura),
CONSTRAINT fk_facturas_zapatillas
	FOREIGN KEY (Id_zapatillas) 
	REFERENCES Zapatillas (Id_zapatillas) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_factura_empleados
	FOREIGN KEY (Id_empleado) 
	REFERENCES Empleados (Id_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_factura_cliente
	FOREIGN KEY (Id_cliente) 
	REFERENCES Clientes (Id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

 /*
 -- Ejercicio Pair Programming MODIFICACIÓN BBDD.
1. En este ejercicio vamos a corregir los errores que hemos encontrado en nuestras tablas. Tabla Zapatillas:
Se nos ha olvidado introducir la marca y la talla de las zapatillas que tenemos en nuestra BBDD. Por lo tanto, debemos incluir...
marca: es una cadena de caracteres de longitud máxima de 45 caracteres, no nula.
talla: es un entero, no nulo.
 */
ALTER TABLE Zapatillas
ADD COLUMN Marca VARCHAR(45) NOT NULL, 
ADD COLUMN Talla INT NOT NULL;

-- Tabla Empleados. salario: es un entero, no nulo. Pero puede que el salario de nuestros empleados tenga decimales, por lo que le cambiaremos el tipo a decimal.;
ALTER TABLE Empleados
MODIFY Salario FLOAT NOT NULL;

-- Tabla Clientes. pais: la hemos incluido en la tabla pero nuestro negocio solo distribuye a España, por lo que es una columna que no hará falta. La eliminaremos.;
ALTER TABLE Clientes
DROP COLUMN Pais;

-- Tabla Facturas. total: madre mía!!! Se nos ha olvidado incluir el total de la cada factura generada😨!Creemos esa columna con un tipo de datos decimal.;
ALTER TABLE Facturas
ADD COLUMN Total FLOAT;

/*
2. Lo primero que vamos a hacer es insertar datos en nuestra BBDD.
 */
INSERT INTO Zapatillas (Id_zapatillas, Modelo, Color, Marca, Talla)
VALUES (1, 'XQYUN', 'Negro', 'Nike', 42),
		(2, 'UOPMN', 'Rosas', 'Nike', 39),
        (3, 'OPNYT', 'Verdes', 'Adidas', 35);
        
INSERT INTO Clientes (Id_cliente, Nombre, Numero_telefono, Email, Direccion, Ciudad, Provincia, Codigo_postal)
VALUES (1, 'Mónica', 1234567289, 'monica@gmail.com', 'Calle Felicidad', 'Móstoles', 'Madrid', 28176),
		(2, 'Lorena', 289345678, 'lorena@gmail.com', 'Calle Alegría', 'Barcelona', 'Barcelona', 12346),
        (3, 'Carmen', 298463759, 'carmen@gmail.com', 'Calle del Color', 'Vigo', 'Pontevedra', 23456);

INSERT INTO Empleados (Id_empleado, Nombre, Tienda, Salario, Fecha_incorporacion)
VALUES (1, 'Laura', 'Alcobendas', 25987, '2010-09-03'),
		(2, 'Maria', 'Sevilla', 0, '2001-04-11'),
        (3, 'Ester', 'Oviedo', 30165.98, '2000-11-29');
        
INSERT INTO Facturas (Id_factura, Numero_factura, Fecha, Id_Zapatillas, Id_empleado, Id_cliente, Total)
VALUES (1, '123', '2001-12-11', 1, 2, 1, 54.98),
		(2, '1234', '2005-05-23', 1, 1, 3, 89.91),
        (3, '12345', '2015-09-18', 2, 3, 3, 76.23);

/*
3. De nuevo nos hemos dado cuenta que hay algunos errores en la inserción de datos. En este ejercicios los actualizaremos para que nuestra BBDD este perfectita.
-- Tabla zapatillas. En nuestra tienda no vendemos zapatillas Rosas... ¿Cómo es posible que tengamos zapatillas de color rosa? 🤔 En realidad esas zapatillas son amarillas.
 */
UPDATE 	Zapatillas
SET Color = 'Amarillas'
WHERE Id_zapatillas = 2;

-- Tabla empleados. Laura se ha cambiado de ciudad y ya no vive en Alcobendas, se fue cerquita del mar, ahora vive en A Coruña.;
UPDATE Empleados
SET Tienda = 'A Coruña'
WHERE Id_empleado = 1;

-- Tabla clientes. El número de telefono de Mónica esta mal!!! Metimos un dígito de más. En realidad su número es: 123456728
UPDATE Clientes
SET Numero_telefono = 123456728
WHERE Nombre = 'Mónica';

-- Tabla facturas. El total de la factura de la zapatilla cuyo id es 2 es incorrecto. En realidad es: 89,91.
UPDATE Facturas
SET Total = 89.91
WHERE Id_factura = 2;







