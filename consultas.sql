-- clientes con pedidos entre dos fechas
select 
    c.id_cliente, 
    p.nombre, 
    p.telefono, 
    ped.id_pedido, 
    ped.fecha
from cliente c
join persona p on c.id_persona = p.id_persona
join pedido ped on c.id_cliente = ped.id_cliente
where ped.fecha between '2025-01-01' and '2025-01-31';

-- pizzas mas vendidas
select 
    dp.id_pizza, 
    p.nombre, 
    count(*) as cantidad_vendida
from detalle_pedido dp
join pizza p on dp.id_pizza = p.id_pizza
group by dp.id_pizza, p.nombre
order by cantidad_vendida desc;


-- pedidos por repartidor
select 
    r.id_repartidor, 
    per.nombre as repartidor,
    z.nombre as zona,
    ped.id_pedido, 
    d.hora_salida, 
    d.hora_entrega
from repartidor r
join persona per on r.id_persona = per.id_persona
join zona z on r.id_zona = z.id_zona
join domicilio d on r.id_repartidor = d.id_repartidor
join pedido ped on ped.id_pedido = d.id_pedido;

-- promedio de entrega por zona
select 
    z.nombre as zona, 
    avg(timestampdiff(minute, d.hora_salida, d.hora_entrega)) as tiempo_promedio_minutos
from repartidor r
join zona z on r.id_zona = z.id_zona
join domicilio d on r.id_repartidor = d.id_repartidor
group by z.nombre;

-- clientes que gastaron mas de un monto
select 
    c.id_cliente, 
    p.nombre, 
    sum(ped.precio_total) as total_gastado
from cliente c
join persona p on c.id_persona = p.id_persona
join pedido ped on c.id_cliente = ped.id_cliente
group by c.id_cliente, p.nombre
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