 /*
 -- Ejercicio Pair Programming CREACIÓN BBDD
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
 -- Ejercicio Pair Programming MODIFICACIÓN BBDD
 */

ALTER TABLE Zapatillas
ADD COLUMN Marca VARCHAR(45) NOT NULL, 
ADD COLUMN Talla INT NOT NULL;

ALTER TABLE Empleados
MODIFY Salario FLOAT NOT NULL;

ALTER TABLE Clientes
DROP COLUMN Pais;

ALTER TABLE Facturas
ADD COLUMN Total FLOAT;

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

UPDATE 	Zapatillas
SET Color = 'Amarillas'
WHERE Id_zapatillas = 2;

UPDATE Empleados
SET Tienda = 'A Coruña'
WHERE Id_empleado = 1;






