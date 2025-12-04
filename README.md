Descripción del Proyecto

El sistema de gestión de la Pizzería Don Piccolo es una base de datos en MySQL diseñada para administrar clientes, pizzas, ingredientes, pedidos, repartidores y domicilios.
El objetivo principal es optimizar todas las operaciones del negocio:
desde el registro del pedido, la preparación, la entrega y el cálculo del total, hasta el control del inventario y la generación de reportes.

Este proyecto incluye:

Creación de tablas y relaciones

Inserción de datos de prueba

Funciones

Triggers

Vistas

Consultas avanzadas

Documentación completa de uso

🗂️ Estructura del Proyecto
/pizzeria-don-piccolo/
 ├── database.sql
 ├── funciones.sql
 ├── triggers.sql
 ├── vistas.sql
 ├── consultas.sql
 └── README.md



 Tablas y Relaciones
persona

Datos generales: documento, nombre, apellido, teléfono, dirección y correo.

cliente

Relación 1:1 con persona. Representa a los compradores registrados.

empleado

Relación 1:1 con persona. Tipo: pizzero, vendedor o mesero.

zona

Zonas de reparto y precio base del domicilio.

repartidor

Asociado a persona + zona.
Estado: disponible / no disponible.

tipo_pago y tipo_pago_domicilio

Métodos de pago permitidos tanto para pedidos en local como domicilios.

pizza

Nombre, tamaño, descripción y precio.

ingrediente

Inventario y costo por unidad.

ingrediente_pizza

Cantidad de cada ingrediente que requiere una pizza.

pedido

Cliente, empleado que lo atiende, tipo de pago, hora, fecha, estado y precio total.

detalle_pedido

Las pizzas solicitadas dentro del pedido.

domicilio

Pedido, repartidor asignado, distancia, horas y costo del envío.




Funciones (funciones.sql)
1. calcular_total_pedido(id_pedido)

Devuelve el total del pedido incluyendo:

Subtotal de pizzas

Costo del domicilio (si aplica)

IVA (19%)

2. calcular_ganancia_diaria(fecha_x)

Devuelve la ganancia de un día:
ventas – costo de ingredientes utilizados.




Triggers (triggers.sql)
1. trg_descontar_ingredientes

Reduce automáticamente el stock de ingredientes cuando se registra un detalle de pedido.

2. trg_repartidor_disponible

Cuando un domicilio registra hora_entrega, el repartidor vuelve a “disponible”.





Vistas (vistas.sql)
1. vista_resumen_pedidos_cliente

Muestra:

Nombre del cliente

Total de pedidos

Total gastado

2. vista_desempeno_repartidores

Incluye métricas del repartidor:

Zona

Número de entregas

Tiempo promedio

3. vista_ingredientes_bajo_stock

Lista los ingredientes cuyo stock está por debajo del nivel mínimo.





Consultas Avanzadas (consultas.sql)

Incluye:

Clientes con pedidos entre fechas (BETWEEN)

Pizzas más vendidas (GROUP BY + COUNT)

Pedidos por repartidor (JOIN)

Promedio de tiempo de entrega por zona (AVG)

Clientes con gastos mayores a un valor (HAVING)

Búsqueda parcial de pizzas (LIKE)

Subconsulta de clientes frecuentes (+5 pedidos al mes)





Instrucciones de Ejecución

Abrir MySQL Workbench o consola.

Ejecutar database.sql para crear tablas y relaciones.

Ejecutar funciones.sql.

Ejecutar triggers.sql.

Ejecutar vistas.sql.

Ejecutar consultas.sql para verificar funcionamiento.





Autor

Luis
Proyecto académico — Base de Datos II
Pizzería Don Piccolo 🍕