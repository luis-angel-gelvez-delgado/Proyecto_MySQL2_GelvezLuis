- funcion para calcular el total de un pedido

DELIMITER //

CREATE FUNCTION calcular_total_pedido(p_id_pedido INT) 
RETURNS double
NOT ETERMINISTIC
BEGIN
    DECLARE v_subtotal DOUBLE DEFAULT 0;
    DECLARE v_envio DOUBLE DEFAULT 0;
    DECLARE v_iva DOUBLE DEFAULT 0;
    DECLARE v_total DOUBLE DEFAULT 0;
    DECLARE v_tipo_pedido ENUM('domicilio', 'local');

    -- Obtener el tipo de pedido
    SELECT tipo_pedido
    INTO v_tipo_pedido
    FROM pedido
    WHERE id_pedido = p_id_pedido;

    -- subtotal de las pizzas
    SELECT COALESCE(SUM(dp.subtotal), 0)
    INTO v_subtotal
    FROM detalle_pedido dp
    WHERE dp.id_pedido = p_id_pedido;

    -- ver wsi el pedido es a domicilio o local
    IF v_tipo_pedido = 'domicilio' THEN
        -- calcular el costo por si es a domicilio
        SELECT COALESCE(d.precio_domicilio, 0)
        INTO v_envio
        FROM domicilio d
        WHERE d.id_pedido = p_id_pedido;
    ELSE
        -- si es para local, el costo de envío es 0
        SET v_envio = 0;
    END IF;

    -- Calcular el IVA (19% del subtotal + envío)
    SET v_iva = (v_subtotal + v_envio) * 0.19;

    -- Calcular el total
    SET v_total = v_subtotal + v_envio + v_iva;

    RETURN v_total;
END; //

DELIMITER ;












