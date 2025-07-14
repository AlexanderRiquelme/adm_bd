-- 1.-  Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
select username, id_tipo_usuario from usuarios where id_tipo_usuario = 2;

-- 2.-  Mostrar Personas nacidas despues del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username.
select nombre_completo, fecha_nac, username from personas, usuarios where fecha_nac > '1990-12-31';

-- 3.- Seleccionar nombres de personas que comiencen con la 
-- letra A - Seleccionar nombre y correo la persona.
select nombre_completo, username, email from personas, usuarios where nombre_completo like 'A%' ;

-- 4.- Mostrar usuarios cuyos dominios de correo sean
-- mail.commit LIKE '%mail.com%'
select email from usuarios where mail.commit LIKE '%mail.com%';

-- 5.- Mostrar todas las personas que no viven en 
 -- Valparaiso y su usuario + ciudad.
 -- select * from ciudad; -- ID 2 VALPARAISO
select id_ciudad, nombre_completo from personas
where id_ciudad <> 2;

-- 6.- Mostrar usuarios que contengan más de 7 
-- carácteres de longitud.
select username
from usuarios
where char_length(username) > 7;

-- 7.- Mostrar username de personas nacidas entre
-- 1990 y 1995
SELECT nombre_completo, fecha_nac
from personas
where fecha_nac <= '1995-12-31' and fecha_nac >= '1995-01-01';