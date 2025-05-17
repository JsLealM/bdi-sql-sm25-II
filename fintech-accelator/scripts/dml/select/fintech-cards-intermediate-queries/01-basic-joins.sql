-- JOINS APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 10/05/2025

/**
INNER JOIN: Listar todas las transacciones con detalles del cliente, 
incluyendo nombre del cliente, monto de la transacción, 
nombre del comercio y método de pago utilizado.
**/

-- JOIN (transactions -> merchant_locations -> credit_cards -> clients ->payment_methods)
SELECT 
    (cl.first_name ||' '||COALESCE(cl.middle_name, '')||' '||cl.last_name) AS client,
    tr.amount AS transaction_amount,
    ml.store_name AS purchased_store,
    pm.name AS payment_method

FROM fintech.transactions AS tr
    INNER JOIN fintech.merchant_locations AS ml
    ON tr.location_id = ml.location_id
    INNER JOIN fintech.credit_cards AS cc
    ON tr.card_id = cc.card_id
    INNER JOIN fintech.clients AS cl
    ON cl.client_id = cc.client_id
    INNER JOIN fintech.payment_methods AS pm
    ON tr.method_id = pm.method_id

LIMIT 10;

/**
LEFT JOIN: Listar todos los clientes y sus tarjetas de crédito, 
incluyendo aquellos clientes que no tienen ninguna 
tarjeta registrada en el sistema.
**/
SELECT cl.client_id,cc.card_id
FROM fintech.clients cl
LEFT JOIN fintech.credit_cards cc
ON cl.client_id = cc.client_id; 


/**
RIGHT JOIN: Listar todas las ubicaciones comerciales y las transacciones 
realizadas en ellas, incluyendo aquellas ubicaciones donde 
aún no se han registrado transacciones.
**/

SELECT ml.location_id, tr.transaction_id
FROM  fintech.transactions tr 
RIGHT JOIN fintech.merchant_locations ml
ON ml.location_id = tr.location_id;

/**
FULL JOIN: Listar todas las franquicias y los países donde operan, 
incluyendo franquicias que no están asociadas a ningún país 
específico y países que no tienen franquicias operando en ellos.
**/
SELECT fs.name, co.name
FROM fintech.franchises fs
FULL JOIN fintech.countries co
on fs.country_code = co.country_code;

/**
SELF JOIN: Encontrar pares de transacciones realizadas por el mismo 
cliente en la misma ubicación comercial en diferentes
**/

SELECT 
t1.transaction_id AS transaccion_1,
t2.transaction_id AS transaccion_2,
c1.client_id,
t1.location_id,
t1.transaction_date AS fecha_1,
t2.transaction_date AS fecha_2
FROM fintech.transactions t1
INNER JOIN fintech.credit_cards c1 
ON t1.card_id = c1.card_id
SELF JOIN fintech.transactions t2 
ON t1.location_id = t2.location_id 
AND t1.transaction_id < t2.transaction_id
INNER JOIN fintech.credit_cards c2 
ON t2.card_id = c2.card_id
WHERE c1.client_id = c2.client_id
AND t1.transaction_date <> t2.transaction_date;

