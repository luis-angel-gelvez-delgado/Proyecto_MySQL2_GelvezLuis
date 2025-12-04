
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


-- Inserciones de zonas
INSERT INTO zona (nombre, precio_domicilio) VALUES
('Bucaramanga', 3500),
('Norte', 4000),
('Floridablanca', 5000);

-- Insertar clientes de los que hay en persona
INSERT INTO cliente (id_persona) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);

-- Insertar empleados con su cargo
INSERT INTO empleado (id_persona, cargo) VALUES
(13, 'pizzero'),
(14, 'mesero'),
(15, 'vendedor'),
(16, 'pizzero');

-- Insertar repartidores con zona y estado
INSERT INTO repartidor (id_persona, id_zona, estado) VALUES
(17, 1, 'disponible'),
(18, 2, 'disponible'),
(19, 3, 'no disponible'),
(20, 1, 'disponible');

-- Insertar pizzas
INSERT INTO pizza (nombre, tamano, descripcion, precio)
VALUES
('Margarita', 'mediana', 'Queso mozzarella y salsa de tomate', 18000),
('Hawaiana', 'mediana', 'Jamon y pina', 22000),
('Pepperoni', 'familiar', 'Pepperoni y queso mozzarella', 35000),
('Vegetariana', 'mediana', 'Verduras mixtas y queso', 25000),
('Cuatro Quesos', 'mini', 'Mezcla de quesos especiales', 15000); 

INSERT INTO ingrediente (nombre, stock, precio)
VALUES
('Queso mozzarella', 50, 3000),
('Salsa de tomate', 40, 1500),
('Jamon', 30, 2500),
('Pina', 25, 2000),
('Pepperoni', 40, 2800),
('Verduras mixtas', 20, 2200),
('Quesos especiales', 15, 3500);


-- Asociar ingredientes a pizzas
-- Margarita (id 1)
INSERT INTO ingrediente_pizza (id_ingrediente, id_pizza, cantidad) VALUES
(1, 1, 2),  -- queso
(2, 1, 1);  -- salsa

-- Hawaiana (id 2)
INSERT INTO ingrediente_pizza (id_ingrediente, id_pizza, cantidad) VALUES
(1, 2, 2),
(2, 2, 1),
(3, 2, 2), -- jamon
(4, 2, 1); -- pina

-- Pepperoni (id 3)
INSERT INTO ingrediente_pizza (id_ingrediente, id_pizza, cantidad) VALUES
(1, 3, 2),
(2, 3, 1),
(5, 3, 3); -- pepperoni

-- Vegetariana (id 4)
INSERT INTO ingrediente_pizza (id_ingrediente, id_pizza, cantidad) VALUES
(1, 4, 1),
(2, 4, 1),
(6, 4, 2); -- verduras

-- Cuatro quesos (id 5)
INSERT INTO ingrediente_pizza (id_ingrediente, id_pizza, cantidad) VALUES
(1, 5, 1),
(7, 5, 2); -- quesos especiales


-- Inserciones tipo_pago
INSERT INTO tipo_pago (metodo, subtotal)
VALUES
('efectivo', 0),
('tarjeta credito', 0),
('tarjeta debito', 0),
('transferencia', 0);

-- Inserciones tipo_pago_domicilio
INSERT INTO tipo_pago_domicilio (metodo, subtotal)
VALUES
('efectivo', 0),
('tarjeta credito', 0),
('tarjeta debito', 0),
('transferencia', 0);


-- inserciones en pedido
INSERT INTO pedido (id_cliente, id_empleado, id_tipo_pago, tipo_pedido, fecha, hora, estado, precio_total)
VALUES
(1, 1, 1, 'local',     '2025-01-10', '12:30:00', 'en preparacion', 0),
(2, 2, 2, 'domicilio', '2025-01-11', '13:45:00', 'en camino',       0),
(3, 3, 3, 'local',     '2025-01-12', '15:10:00', 'entregado',       0),
(4, 4, 1, 'domicilio', '2025-01-12', '18:20:00', 'en preparacion', 0),
(5, 1, 4, 'local',     '2025-01-13', '16:50:00', 'cancelado',       0);

-- detalle_pedido
INSERT INTO detalle_pedido (id_pedido, id_pizza, cantidad, subtotal) VALUES
-- Pedido 1
(1, 1, 2, 36000),
(1, 3, 1, 35000),
-- Pedido 2
(2, 2, 1, 22000),
(2, 3, 1, 35000),
-- Pedido 3
(3, 4, 1, 25000),
-- Pedido 4
(4, 5, 2, 30000),
-- Pedido 5 (cancelado pero con elementos)
(5, 1, 1, 18000);

-- domicilios (solo para pedidos tipo domicilio: 2 y 4)
INSERT INTO domicilio (
    id_pedido, id_repartidor, id_tipo_pago_domicilio, direccion, hora_salida, hora_entrega, distancia, precio_domicilio
) VALUES
(2, 1, 1, 'Carrera 10 #20-30', '2025-01-11 13:50:00', '2025-01-11 14:20:00', 4.2, 5000),
(4, 2, 1, 'Avenida 5 #15-25', '2025-01-12 18:30:00', '2025-01-12 19:05:00', 3.8, 5000);
