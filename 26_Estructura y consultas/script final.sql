-- Creación de la base de datos
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    nombre_tipo VARCHAR(50) NOT NULL check(nombre_tipo in ('Administrador','Cliente','Moderador')), 
    descripcion_tipo VARCHAR(200) NOT NULL,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    created_by int,
    updated_by int,
    deleted boolean default false
);

-- Tabla: usuarios (se añade campo created_at con valor por defecto)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE check(char_length(username) >=4), -- Asegurarse de que el nombre ingresado sea almenos 4 caracteres de largo
    password VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE check(email like '%@%.%'), -- Impide que el correo tenga una estructura distinta a 'hola@1234.cl'
    id_tipo_usuario INT,
	created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    created_by int,
    updated_by int,
    deleted boolean default false,
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo)
);

-- Tabla: ciudad (nueva)
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL,
    region VARCHAR(100) check(region in ('Región de Arica y Parinacota','Región de Tarapacá',
										'Región de Antofagasta','Región de Atacama',
										'Región de Coquimbo','Región de Valparaíso',
										'Región Metropolitana',"Región del Libertador General Bernardo O'Higgins",
										'Región del Maule','Región de Ñuble',
                                        'Región del Biobío','Región de la Araucanía',
                                        'Región de Los Ríos','Región de Los Lagos',
                                        'Región de Aysén del General Carlos Ibáñez del Campo','Región de Magallanes y de la Antártica Chilena')), -- Solo permitir las 16 regiones existentes en chile
	created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    created_by int,
    updated_by int,
    deleted boolean default false
);

-- Tabla: personas (relacionada con usuarios y ciudad)
CREATE TABLE personas (
    rut VARCHAR(13) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nac DATE check(fecha_nac <= '2025-12-31' and fecha_nac >= '1900-01-01'), -- Asegurarse que el usuario no tenga 200 años o que haya nacido en el futuro
    id_usuario INT,
    id_ciudad INT,
	created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    created_by int,
    updated_by int,
    deleted boolean default false,
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);