-- Creacion de la database
create database pizzeria_don_piccolo;
use pizzeria_don_piccolo;






-- tabla persona
create table persona(
   id_persona int primary key auto_increment not null,
   tipo_documento enum('cedula', 'cedula extranjera', 'tarjeta de identidad') not null,
   documento int not null,
   nombre varchar(50) not null,
   apellido varchar(50) not null,
   telefono varchar(15) not null,
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


-- tabla tipo_pago
create table tipo_pago(
   id_tipo_pago int primary key auto_increment not null,
   metodo enum('efectivo', 'tarjeta credito', 'tarjeta debito', 'transferencia') not null,
   subtotal double not null
);


-- tabla tipo_pago_domicilio
create table tipo_pago_domicilio(
   id_tipo_pago_domicilio int primary key auto_increment not null,
   metodo enum('efectivo', 'tarjeta credito', 'tarjeta debito', 'transferencia') not null,
   subtotal double not null
);


-- tabla pedido
create table pedido(
   id_pedido int primary key auto_increment not null,
   id_cliente int not null,
   id_empleado int not null,
   id_tipo_pago int not null,
   tipo_pedido enum('domicilio', 'local') not null,
   fecha datetime not null,
   hora time not null,
   estado enum('en preparacion', 'en camino', 'entregado', 'cancelado') not null,
   precio_total double not null,
   foreign key (id_cliente) references cliente(id_cliente),
   foreign key (id_empleado) references empleado(id_empleado),
   foreign key (id_tipo_pago) references tipo_pago(id_tipo_pago)
);


-- tabla domicilio
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


-- tabla pizza
create table pizza(
   id_pizza int primary key auto_increment not null,
   nombre varchar(50) not null,
   tamano enum('mini', 'mediana', 'familiar') not null,
   descripcion varchar(200) not null,
   precio double not null
);


-- tabla detalle_pedido
create table detalle_pedido(
   id_detalle_pedido int primary key auto_increment not null,
   id_pedido int not null,
   id_pizza int not null,
   cantidad int not null,
   subtotal double not null,
   foreign key (id_pedido) references pedido(id_pedido),
   foreign key (id_pizza) references pizza(id_pizza)
);


-- tabla ingrediente
create table ingrediente(
   id_ingrediente int primary key auto_increment not null,
   nombre varchar(50) not null,
   stock int not null,
   precio double not null
);


-- tabla ingrediente_pizza
create table ingrediente_pizza(
   id_ingrediente_pizza int primary key auto_increment not null,
   id_ingrediente int not null,
   id_pizza int not null,
   cantidad int not null,
   foreign key (id_ingrediente) references ingrediente(id_ingrediente),
   foreign key (id_pizza) references pizza(id_pizza)
);





-- Inserciones en la tabla persona
INSERT INTO persona (tipo_documento, documento, nombre, apellido, telefono, direccion, email)
VALUES 
('cedula', 10000001, 'Juan', 'Pérez', 3001234567, 'Calle 123 #45-67', 'juan.perez@example.com'),
('cedula', 10000002, 'Maria', 'Gomez', 3107654321, 'Carrera 10 #20-30', 'maria.gomez@example.com'),
('tarjeta de identidad', 10000003, 'Carlos', 'Ramirez', 3209876543, 'Avenida 5 #15-25', 'carlos.ramirez@example.com'),
('cedula', 10000004, 'Ana', 'Lopez', 3012345678, 'Diagonal 25 #50-60', 'ana.lopez@example.com'),
('cedula', 10000005, 'Luis', 'Martinez', 3118765432, 'Transversal 8 #40-50', 'luis.martinez@example.com'),
('cedula', 10000006, 'Sofia', 'Rodriguez', 3023456789, 'Calle 50 #30-40', 'sofia.rodriguez@example.com'),
('cedula', 10000007, 'Miguel', 'Torres', 3034567890, 'Carrera 15 #10-20', 'miguel.torres@example.com'),
('cedula extranjera', 10000008, 'Laura', 'Hernandez', 3045678901, 'Avenida 20 #5-15', 'laura.hernandez@example.com'),
('cedula', 10000009, 'Andres', 'Garcia', 3056789012, 'Calle 80 #60-70', 'andres.garcia@example.com'),
('cedula', 10000010, 'Camila', 'Moreno', 3067890123, 'Carrera 25 #35-45', 'camila.moreno@example.com'),
('cedula', 10000011, 'Jorge', 'Vargas', 3078901234, 'Diagonal 10 #20-30', 'jorge.vargas@example.com'),
('cedula', 10000012, 'Valentina', 'Castro', 3089012345, 'Transversal 15 #25-35', 'valentina.castro@example.com'),
('cedula', 10000013, 'Diego', 'Rojas', 3090123456, 'Calle 90 #70-80', 'diego.rojas@example.com'),
('cedula', 10000014, 'Isabella', 'Cruz', 3101234567, 'Carrera 30 #40-50', 'isabella.cruz@example.com'),
('cedula', 10000015, 'Sebastian', 'Mejia', 3112345678, 'Avenida 15 #10-20', 'sebastian.mejia@example.com'),
('cedula', 10000016, 'Daniela', 'Ortiz', 3123456789, 'Calle 100 #80-90', 'daniela.ortiz@example.com'),
('cedula', 10000017, 'Ricardo', 'Guerrero', 3134567890, 'Carrera 35 #45-55', 'ricardo.guerrero@example.com'),
('cedula', 10000018, 'Paula', 'Mendoza', 3145678901, 'Diagonal 20 #30-40', 'paula.mendoza@example.com'),
('cedula', 10000019, 'Fernando', 'Salazar', 3156789012, 'Transversal 5 #15-25', 'fernando.salazar@example.com'),
('cedula', 10000020, 'Carolina', 'Pineda', 3167890123, 'Calle 110 #90-100', 'carolina.pineda@example.com');