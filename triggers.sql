delimiter //

-- trigger 1 disminuir stock al agregar detalle de pedido
create trigger trg_disminuir_stock
after insert on detalle_pedido
for each row
begin
    update pizza
    set stock = stock - new.cantidad
    where id_pizza = new.id_pizza;
end;
//

delimiter ;









delimiter //

-- trigger 2  validar fecha de pedido
create trigger trg_validar_fecha_pedido
before insert on pedido
for each row
begin
    if new.fecha < current_date() then
        signal sqlstate '45000'
        set message_text = 'la fecha del pedido no puede ser anterior a hoy.';
    end if;
end;
//

delimiter ;
