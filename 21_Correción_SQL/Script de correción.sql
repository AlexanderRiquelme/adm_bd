USE sistema_ventas_4E;

alter table usuarios
change column correo email varchar(200);

alter table tipo_usuarios
add column descripcion_tipo varchar(200);

alter table productos
change nombre nombre_producto varchar(100) not null;

alter table ventas
modify column fecha date not null;
