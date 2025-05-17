-- JOINS APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 10/05/2025


/**
SUM: Calcular el monto total de transacciones realizadas por cada cliente 
en los últimos 3 meses, mostrando el nombre del cliente y el total gastado.
**/
-- FK: (transactions -> credit_cards -> clients)
SELECT
	cl.client_id,
    (cl.first_name ||' '||cl.last_name) AS client,
    COUNT(*) AS total_transactions_done,
    SUM(tr.amount) AS total_amount_spent
FROM 
    fintech.transactions AS tr
INNER JOIN fintech.credit_cards AS cc
    ON tr.card_id = cc.card_id
INNER JOIN fintech.clients AS cl
    ON cc.client_id = cl.client_id
WHERE 
    tr.transaction_date >= (CURRENT_DATE - INTERVAL '3 months')
GROUP BY cl.client_id, cl.first_name, cl.last_name
ORDER BY cl.client_id DESC
LIMIT 5;

-- check specific transactions
SELECT tr.amount, tr.transaction_date, cc.card_id, cc.client_id
FROM fintech.TRANSACTIONS as tr
INNER JOIN fintech.credit_cards AS cc
ON tr.card_id = cc.card_id
WHERE cc.client_id = '  INS-AUTO17924456385';



/**
AVG: Obtener el valor promedio de las transacciones agrupadas por categoría
de comercio y método de pago, para identificar los patrones de gasto según 
el tipo de establecimiento.
**/

SELECT AVG(tr.amount) AS promedio_transactions,
ml.category as category_locations,
pay.name as payment_methods
FROM fintech.transactions tr
INNER JOIN fintech.merchant_locations ml
ON tr.location_id = ml.location_id
LEFT JOIN fintech.payment_methods pay
ON tr.method_id = pay.method_id
GROUP BY ml.category, pay.name;


/**
COUNT: Contar el número de tarjetas de crédito emitidas por cada entidad 
bancaria (issuer), agrupadas por franquicia, mostrando qué bancos 
tienen mayor presencia por tipo de tarjeta.
**/
SELECT fis.name AS EntidadBancaria,
fc.name AS Franquicia,
COUNT(*) AS Tarjetas
FROM fintech.credit_cards cc
INNER JOIN fintech.franchises fc
ON cc.franchise_id = fc.franchise_id
INNER JOIN fintech.issuers fis
ON fc.issuer_id = fis.issuer_id
GROUP BY fis.name, fc.name
ORDER BY Tarjetas DESC;


/**
MIN y MAX: Mostrar el monto de transacción más bajo y más alto para cada 
cliente, junto con la fecha en que ocurrieron, para identificar patrones 
de gasto extremos.
**/

SELECT cl.client_id, cl.first_name||' '||cl.last_name  AS nombreCompleto, MIN(tr.amount) AS minimo,
MAX(tr.amount) AS Maximo,
(SELECT t.transaction_date 
FROM fintech.transactions t 
INNER JOIN fintech.credit_cards c ON t.card_id = c.card_id 
WHERE c.client_id = cl.client_id AND t.amount = MIN(tr.amount) 
LIMIT 1) AS fecha_monto_minimo,
(SELECT t.transaction_date 
FROM fintech.transactions t 
INNER JOIN fintech.credit_cards c ON t.card_id = c.card_id 
WHERE c.client_id = cl.client_id AND t.amount = MAX(tr.amount) 
LIMIT 1) AS fecha_monto_maximo
FROM fintech.transactions tr
INNER JOIN fintech.credit_cards cc
ON tr.card_id = cc.card_id
INNER JOIN fintech.clients cl
ON cc.client_id = cl.client_id
GROUP BY cl.client_id LIMIT 10;