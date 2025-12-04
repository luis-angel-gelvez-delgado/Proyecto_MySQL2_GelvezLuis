delimiter //

create function calcular_total_pedido(p_id_pedido int)
returns double
reads sql data
not deterministic
begin
    declare v_subtotal double default 0;
    declare v_envio double default 0;
    declare v_total double default 0;
    declare v_tipo_pedido varchar(20);

    select tipo_pedido
    into v_tipo_pedido
    from pedido
    where id_pedido = p_id_pedido;

    select coalesce(sum(dp.subtotal),0)
    into v_subtotal
    from detalle_pedido dp
    where dp.id_pedido = p_id_pedido;

    if v_tipo_pedido = 'domicilio' then
        select coalesce(d.precio_domicilio,0)
        into v_envio
        from domicilio d
        where d.id_pedido = p_id_pedido;
    else
        set v_envio = 0;
    end if;

    set v_total = (v_subtotal + v_envio) * 1.19;

    return v_total;
end; //

delimiter ;











-- funcion para calcular ganancias diarias
delimiter //

create function calcular_ganancia_diaria(p_fecha date)
returns double
reads sql data
not deterministic
begin
    declare v_ventas double default 0;
    declare v_costos double default 0;
    declare v_ganancia double default 0;

    -- total de ventas del dia
    select coalesce(sum(dp.subtotal), 0)
    into v_ventas
    from pedido p
    join detalle_pedido dp on p.id_pedido = dp.id_pedido
    where date(p.fecha) = p_fecha;

    -- costo de ingredientes usados ese dia
    select coalesce(sum(ip.cantidad * i.precio), 0)
    into v_costos
    from pedido p
    join detalle_pedido dp on p.id_pedido = dp.id_pedido
    join ingrediente_pizza ip on dp.id_pizza = ip.id_pizza
    join ingrediente i on ip.id_ingrediente = i.id_ingrediente
    where date(p.fecha) = p_fecha;

    -- ganancia = ventas - costos
    set v_ganancia = v_ventas - v_costos;

    return v_ganancia;
end; //

delimiter ;
