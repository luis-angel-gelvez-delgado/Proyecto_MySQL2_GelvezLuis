-- vista de resumen de pedidos por cliente
create view vista_resumen_pedidos_cliente as
select 
    c.id_cliente,
    c.nombre,
    count(p.id_pedido) as cantidad_pedidos,
    sum(p.total) as total_gastado
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nombre;

-- vista de desempeño de repartidores
create view vista_desempeno_repartidores as
select 
    r.id_repartidor,
    r.nombre,
    r.zona,
    count(d.id_domicilio) as entregas_totales,
    avg(timestampdiff(minute, d.hora_salida, d.hora_entrega)) as tiempo_promedio
from repartidor r
left join domicilio d on r.id_repartidor = d.id_repartidor
group by r.id_repartidor, r.nombre, r.zona;

-- vista de ingredientes con stock bajo
create view vista_stock_bajo as
select 
    i.id_ingrediente,
    i.nombre,
    i.stock,
    i.stock_minimo
from ingrediente i
where i.stock < i.stock_minimo;
