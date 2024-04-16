 /*
 -- Ejercicio Pair Programming CREACIÓN BBDD
 */
 
 CREATE SCHEMA tienda_zapatillas_Pair_Programming;
USE tienda_zapatillas_Pair_Programming;

CREATE TABLE Zapatillas (
    Id_zapatillas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(45) NOT NULL,
    Color VARCHAR(45) NOT NULL
);

CREATE TABLE Clientes (
    Id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45) NOT NULL,
    Numero_telefono INT NOT NULL,
    Email VARCHAR(45) NOT NULL,
    Direccion VARCHAR(45) NOT NULL,
    Ciudad VARCHAR(45),
    Provincia VARCHAR(45) NOT NULL,
    Pais VARCHAR(45) NOT NULL,
    Codigo_postal VARCHAR(45) NOT NULL
);

CREATE TABLE Empleados (
    Id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45) NOT NULL,
    Tienda VARCHAR(45) NOT NULL,
    Salario FLOAT,
    Fecha_incorporacion DATE NOT NULL
);

CREATE TABLE Facturas (
    Id_facturas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Numero_factura VARCHAR(45),
    Fecha DATE NOT NULL,
    Id_zapatillas INT NOT NULL,
    Id_empleado INT NOT NULL,
    Id_cliente INT NOT NULL,
    CONSTRAINT fk_facturas_zapatillas_empleados_clientes
        FOREIGN KEY (Id_zapatillas) REFERENCES Zapatillas (Id_zapatillas) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Id_empleado) REFERENCES Empleados (Id_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Id_cliente) REFERENCES Clientes (Id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);