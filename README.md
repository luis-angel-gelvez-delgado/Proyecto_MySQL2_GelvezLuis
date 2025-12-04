# Pizzería Don Piccolo — Proyecto Base de Datos II

Una colección de scripts SQL para modelar y gestionar las operaciones de la Pizzería Don Piccolo:
- creación de tablas y relaciones
- datos de ejemplo
- funciones, triggers y vistas
- consultas y reportes de apoyo

---

## Índice

- Descripción
- Estructura del proyecto
- Cómo ejecutar los scripts
- Descripción rápida de tablas
- Funciones, Triggers, Vistas y Consultas
- Notas y buenas prácticas
- Autor

---

## Descripción

Este repositorio contiene los scripts para crear una base de datos MySQL que gestiona clientes, empleados, pizzas, ingredientes, pedidos y domicilios. Está pensado como proyecto académico para la asignatura de Base de Datos II.

El objetivo es practicar diseño relacional, procedimientos/funciones, triggers y consultas avanzadas aplicadas a un caso real.

## Estructura del proyecto

Raíz del proyecto:

```
Proyecto_MySQL2_GelvezLuis/
 ├── database.sql        # Creación de tablas e inserciones de ejemplo
 ├── fnciones.sql        # Funciones almacenadas (nota: archivo con nombre tal cual)
 ├── triggers.sql        # Triggers para mantener integridad y lógica de negocio
 ├── vistas.sql          # Vistas útiles para reportes
 ├── consultas.sql       # Consultas de ejemplo y ejercicios
 └── README.md           # Documentación (este archivo)
```


## Cómo ejecutar los scripts (copia y pega los contenidos)

Si prefieres practicar copiando y pegando los contenidos de los archivos en vez de ejecutar los ficheros directamente, sigue este orden y estos pasos:

Orden recomendado (copiar y pegar en este orden):

1. `database.sql`  — crea la base de datos, tablas y añade datos de ejemplo.
2. `funciones.sql`  — funciones almacenadas (puede incluir cambios de DELIMITER).
3. `triggers.sql`   — triggers que dependen de tablas y funciones.
4. `vistas.sql`     — vistas para reportes.
5. `consultas.sql`  — consultas y ejercicios de verificación.

Pasos prácticos:

- Abre la consola `mysql` y conéctate a tu servidor.
- Abre el archivo `database.sql`, selecciona todo su contenido y pégalo en la ventana de consultas. Ejecuta ese bloque (esto crea la base y las tablas).
- Abre `fnciones.sql`, copia su contenido y pégalo en la ventana de consultas. Ten en cuenta los `DELIMITER` que puedan aparecer en ese archivo; ejecútalo tal cual para que las funciones se creen correctamente.
- Repite para `triggers.sql`, `vistas.sql` y `consultas.sql` en ese orden, pegando y ejecutando cada bloque después de pegarlo.

Notas y precauciones:

- Si pegas e intentas ejecutar varias veces los mismos scripts sobre la misma base de datos puedes tener errores por duplicidad (tablas/funciones ya existentes). Si vas a repetir pruebas, considera eliminar la base de datos primero (`DROP DATABASE pizzeria_don_piccolo;`) o cambiar nombres temporales.
- Asegúrate de ejecutar los bloques que contienen `DELIMITER` completos (cambiar delimitador y restaurarlo) cuando pegues funciones o procedimientos.

## Descripción rápida de tablas

- `persona`: datos personales básicos (documento, nombre, teléfono, dirección, email).
- `cliente`: referencia a `persona` para clientes registrados.
- `empleado`: referencia a `persona` y campo `cargo` (pizzero, mesero, vendedor).
- `zona`: zonas de reparto y precio base de domicilio.
- `repartidor`: referencia a `persona` y a `zona`, con estado (disponible/no disponible).
- `pedido`: referencia a cliente, empleado, tipo de pago, fecha/hora, estado y `precio_total`.
- `detalle_pedido`: pizzas dentro de un pedido (cantidad y subtotal).
- `domicilio`: información específica de envíos (repartidor, distancia, horas y precio de envío).
- `pizza`, `ingrediente`, `ingrediente_pizza`: catálogo y relación de ingredientes por pizza.

## Funciones, Triggers y Vistas (resumen)

- Funciones (`fnciones.sql`):
  - `calcular_total_pedido(id_pedido)`: calcula subtotal + envío (si aplica) + IVA (19%).
  - `calcular_ganancia_diaria(fecha)`: suma ingresos menos costo de ingredientes (ejemplo).

- Triggers (`triggers.sql`):
  - `trg_descontar_ingredientes`: reduce stock al registrar detalle de pedido.
  - `trg_repartidor_disponible`: marca repartidor disponible al registrar entrega.

- Vistas (`vistas.sql`):
  - `vista_resumen_pedidos_cliente`: resumen por cliente (total y gasto).
  - `vista_desempeno_repartidores`: métricas por repartidor (entregas, tiempos).
  - `vista_ingredientes_bajo_stock`: ingredientes con stock bajo.

## Consultas destacadas (en `consultas.sql`)

- Clientes con pedidos en un rango de fechas.
- Pizzas más vendidas (GROUP BY + COUNT).
- Pedidos por repartidor (JOIN).
- Promedio de tiempo de entrega por zona (AVG).
- Clientes con gastos mayores a un umbral (HAVING).



## Autor

Luis Ángel Gelvez Delgado — Proyecto CampusLands (MySQL II)

Pizzería Don Piccolo 

---

