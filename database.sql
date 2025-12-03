--Creacion de la database
create database pizzeriaDonPiccolo
use pizzeriaDonPiccolo






--tabla persona
create table persona(
   id_persona int primary key auto_increment not null,
   tipo_documento enum('cedula', 'cedula extranjera', 'trajeta de identidad') not null,
   documento int not null,
   nombre varchar(50) not null,
   apellido varchar(50) not null,
   telefono int not null,
   direccion varchar (100) not null,
   email varchar(100) not null
);


-- tabla cliente
create table cliente(
   id_cliente int primary key auto_increment not null,
   id_persona int not null,
   foreign key (id_persona) references persona(id_persona)
);


-- tabla empleado
create table empleado(
   id_empleado int primary key auto_increment not null,
   id_persona int not null,
   cargo enum('vendedor', 'pizzero', 'mesero') not null,
   foreign key (id_persona) references persona(id_persona)
);


-- tabla zona
create table zona(
   id_zona int primary key auto_increment not null,
   nombre varchar(50) not null,
   precio_domicilio double not null
);


-- tabla repartidor
create table repartidor(
   id_repartidor int primary key auto_increment not null,
   id_persona int not null,
   id_zona int not null,
   estado enum('disponible', 'no disponible') not null,
   foreign key (id_persona) references persona(id_persona),
   foreign key (id_zona) references zona(id_zona)
);


--tabla tipo_pago
create table tipo_pago(
   id_tipo_pago int primary key auto_increment not null,
   metodo enum('efectivo', 'tarjeta credito', 'tarjeta debito', 'transferencia') not null,
   subtotal double not null
);


--tabla tipo_pago_domicilio
create table tipo_pago_domicilio(
   id_tipo_pago_domicilio int primary key auto_increment not null,
   metodo enum('efectivo', 'tarjeta credito', 'tarjeta debito', 'transferencia') not null,
   subtotal double not null
);


--tabla pedido
create table pedido(
   id_pedido int primary key auto_increment not null,
   id_cliente int not null,
   id_empleado int not null,
   tipo_pedido enum('domicilio', 'local') not null,
   fecha datetime not null,
   hora time not null,
   estado enum('en preparacion', 'en camino', 'entregado', 'cancelado') not null,
   precio_total double not null,
   foreign key (id_cliente) references cliente(id_cliente),
   foreign key (id_empleado) references empleado(id_empleado),
   foreign key (tipo_pago) references tipo_pago(metodo)
);


--tabla domicilio
create table domicilio(
   id_domicilio int primary key auto_increment not null,
   id_pedido int not null,
   id_repartidor int not null,
   id_tipo_pago_domicilio int not null,
   direccion varchar(100) not null,
   precio_domicilio double not null,
   hora_salida time not null,
   hora_entrega time not null,
   distancia decimal(10,2) not null,
   foreign key (id_pedido) references pedido(id_pedido),
   foreign key (id_repartidor) references repartidor(id_repartidor),
   foreign key (id_tipo_pago_domicilio) references tipo_pago_domicilio(id_tipo_pago_domicilio)
);


--tabla pizza
create table pizza(
   id_pizza int primary key auto_increment not null,
   nombre varchar(50) not null,
   tamano enum('mini', 'mediana', 'familiar') not null,
   descripcion varchar(200) not null,
   precio double not null
);


--tabla detalle_pedido
create table detalle_pedido(
   id_detalle_pedido int primary key auto_increment not null,
   id_pedido int not null,
   id_pizza int not null,
   cantidad int not null,
   subtotal double not null,
   foreign key (id_pedido) references pedido(id_pedido),
   foreign key (id_pizza) references pizza(id_pizza)
);


--tabla ingrediente
create table ingrediente(
   id_ingrediente int primary key auto_increment not null,
   nombre varchar(50) not null,
   stock int not null,
   precio double not null
);


--tabla ingrediente_pizza
create table ingrediente_pizza(
   id_ingrediente_pizza int primary key auto_increment not null,
   id_ingrediente int not null,
   id_pizza int not null,
   cantidad int not null,
   foreign key (id_ingrediente) references ingrediente(id_ingrediente),
   foreign key (id_pizza) references pizza(id_pizza)
);

