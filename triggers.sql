delimiter //
-- trigger 1  descontar ingredientes al insertar detalle_pedido
create trigger trg_descontar_ingredientes
after insert on detalle_pedido
for each row
begin
    update ingrediente i
    join ingrediente_pizza ip on i.id_ingrediente = ip.id_ingrediente
    set i.stock = i.stock - (ip.cantidad * new.cantidad)
    where ip.id_pizza = new.id_pizza;
end;
//

delimiter ;









delimiter //
-- trigger 2  actualizar estado repartidor al asignar domicilio
create trigger trg_repartidor_disponible
after update on domicilio
for each row
begin
    if new.hora_entrega is not null and old.hora_entrega is null then
        update repartidor
        set estado = 'disponible'
        where id_repartidor = new.id_repartidor;
    end if;
end;
//

delimiter ;
