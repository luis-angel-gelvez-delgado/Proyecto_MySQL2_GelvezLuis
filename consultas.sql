-- clientes con pedidos entre dos fechas
select c.id_cliente, c.nombre, c.telefono, p.id_pedido, p.fecha
from cliente c
join pedido p on c.id_cliente = p.id_cliente
where p.fecha between '2025-01-01' and '2025-01-31';

-- pizzas mas vendidas
select dp.id_pizza, p.nombre, count(*) as cantidad_vendida
from detalle_pedido dp
join pizza p on dp.id_pizza = p.id_pizza
group by dp.id_pizza, p.nombre
order by cantidad_vendida desc;

-- pedidos por repartidor
select r.id_repartidor, r.nombre, p.id_pedido, d.hora_salida, d.hora_entrega
from repartidor r
join domicilio d on r.id_repartidor = d.id_repartidor
join pedido p on p.id_pedido = d.id_pedido;

-- promedio de entrega por zona
select r.zona, avg(timestampdiff(minute, d.hora_salida, d.hora_entrega)) as tiempo_promedio
from repartidor r
join domicilio d on r.id_repartidor = d.id_repartidor
group by r.zona;

-- clientes que gastaron mas de un monto
select c.id_cliente, c.nombre, sum(p.total) as total_gastado
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nombre
having total_gastado > 200000;

-- busqueda parcial de pizza por nombre
select *
from pizza
where nombre like '%pollo%';

-- clientes frecuentes
select *
from cliente
where id_cliente in (
    select id_cliente
    from pedido
    where month(fecha) = month(curdate())
    group by id_cliente
    having count(*) > 5
);
