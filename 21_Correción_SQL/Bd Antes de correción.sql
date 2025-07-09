create database sistema_ventas_4E;
USE sistema_ventas_4E;
-- Creamos la tabla tipo_usuario
CREATE TABLE tipo_usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
-- Identificador único
nombre_tipo VARCHAR(50) NOT NULL,
-- Tipo de usuario (Admin, Cliente)
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT,-- Usuario que crea
updated_by INT,-- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Tabla para usuarios

CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY, -- Id único
nombre_tipo VARCHAR(100) NOT NULL, -- Nombre de usuario
correo VARCHAR(100) UNIQUE, -- Correo electrónico único
tipo_usuario_id INT, -- Relación a tipo_usuario
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT,-- Usuario que crea
updated_by INT,-- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

ALTER TABLE usuarios -- Modificar tabla
-- Agregar una restricción (FK)

ADD CONSTRAINT fk_usuario_tipo_usuario

-- Añade referencia(FK)

FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id);

CREATE TABLE productos (
id_producto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
precio FLOAT,
stock INT,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by int,
updated_by int,
deleted BOOLEAN DEFAULT FALSE
);
create table ventas (
id_venta INT AUTO_INCREMENT PRIMARY KEY,
id_usuario int,
fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by int,
updated_by int,
deleted BOOLEAN DEFAULT FALSE
);
create table detalle_ventas (
id_detalle INT AUTO_INCREMENT PRIMARY KEY,
venta_id int,
producto_id int,
cantidad int,
precio_unitario float,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by int,
updated_by int,
deleted BOOLEAN DEFAULT FALSE
);


ALTER TABLE ventas -- Modificar tabla
-- Agregar una restricción (FK)

ADD CONSTRAINT fk_producto_id_usuario

-- Añade referencia(FK)

FOREIGN KEY (id_usuario) REFERENCES
usuarios(id_usuario);

ALTER TABLE detalle_ventas -- Modificar tabla
-- Agregar una restricción (FK)

ADD CONSTRAINT fk_detalle_ventas_ventas

-- Añade referencia(FK)

FOREIGN KEY (venta_id) REFERENCES
ventas(id_venta);

ALTER TABLE detalle_ventas -- Modificar tabla
-- Agregar una restricción (FK)

ADD CONSTRAINT fk_ventas_ventas_productos

-- Añade referencia(FK)

FOREIGN KEY (producto_id) REFERENCES
productos(id_producto);