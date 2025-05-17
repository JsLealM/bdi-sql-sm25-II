-- GROUP BY AND HAVING APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 16/05/202

/**
1. Identificación de Clientes de Alto Valor:
Calcule los totales de gastos de seis meses por cliente,
filtrando aquellos que superan los $7,750,424,420,346.32 (~7.75 billones),
incluyendo identificación completa del cliente y frecuencia de transacciones.
*/
SELECT cl.client_id, cl.first_name||' '||cl.last_name,
cl.email, cl.phone,
COUNT(tr.transaction_id) AS frecuencia_transacciones,
SUM(tr.amount) AS TotalGastado
FROM fintech.clients cl
INNER JOIN fintech.credit_cards cc
ON cl.client_id = cc.client_id
INNER JOIN fintech.transactions tr
ON cc.card_id = tr.card_id
WHERE tr.transaction_date >= (CURRENT_DATE - INTERVAL '6 months')
GROUP BY cl.client_id HAVING SUM(tr.amount) > 7750424420346.32;
/**
2. Análisis de Rendimiento de Categoría Comercial:
Analice categorías comerciales por valor promedio de transacción
por país, filtrando categorías con transacciones promedio superiores a 
$5,497,488,250,176.02 (~5.50 billones) y mínimo 50 operaciones.
**/

SELECT
	ml.category,
  AVG(tr.amount) AS avg_transactions,
  COUNT(tr.transaction_id) AS total_operations_made,
  co.name AS country
FROM 
	fintech.merchant_locations AS ml
INNER JOIN fintech.transactions AS tr
	ON ml.location_id = tr.location_id
INNER JOIN fintech.countries AS co
	ON ml.country_code = co.country_code
--WHERE ml.country_code = 'CO' optional filter by colombia
GROUP BY ml.category, co.name
HAVING AVG(tr.amount) > 5497488250176.02
	AND COUNT(tr.transaction_id) >= 50
ORDER BY total_operations_made DESC;

/**
3. Análisis de Rechazo de Transacciones:
Determine franquicias de tarjetas con tasas elevadas de rechazo de transacciones
por país, mostrando franquicia, país y porcentaje de rechazo, 
filtrado para tasas superiores al 5% con mínimo 100 intentos de transacción.
**/
SELECT 
fc.name AS franquicia,
co.name AS pais,
(COUNT(tr2.transaction_id) * 100.0 / COUNT(tr1.transaction_id)) || '%' AS porcentaje_rechazo
FROM fintech.franchises fc
INNER JOIN fintech.countries co 
ON fc.country_code = co.country_code
INNER JOIN fintech.credit_cards cc 
ON fc.franchise_id = cc.franchise_id
INNER JOIN fintech.transactions tr1 
ON cc.card_id = tr1.card_id
LEFT JOIN fintech.transactions tr2 
ON tr1.transaction_id = tr2.transaction_id AND tr2.status = 'Rejected'
GROUP BY fc.name, co.name
HAVING 
COUNT(tr1.transaction_id) >= 100
AND (COUNT(tr2.transaction_id) * 1.0 / COUNT(tr1.transaction_id)) > 0.05;



/**
4. Distribución Geográfica del Método de Pago:
Analice los métodos de pago dominantes por ciudad, 
incluyendo nombre del método, ciudad, país y volumen de transacciones,
filtrado para métodos que representan más del 20% del volumen 
de transacciones de una ciudad.
**/
SELECT 
pay.name AS metodo_pago,
ml.city AS ciudad,
co.name AS pais,
COUNT(tr1.transaction_id) AS volumen_transacciones,
(COUNT(tr1.transaction_id) * 100.0 / COUNT(tr2.transaction_id)) || '%' AS porcentaje
FROM fintech.payment_methods pay
INNER JOIN fintech.transactions tr1 
ON pay.method_id = tr1.method_id
INNER JOIN fintech.merchant_locations ml 
ON tr1.location_id = ml.location_id
INNER JOIN fintech.countries co 
ON ml.country_code = co.country_code
INNER JOIN fintech.transactions tr2 
ON tr2.location_id = ml.location_id
GROUP BY pay.name, ml.city, co.name
HAVING (COUNT(tr1.transaction_id) * 1.0 / COUNT(tr2.transaction_id)) > 0.20;
/**
5. Análisis de Patrones de Gasto Demográfico:
Evalúe el comportamiento de compra en demografías de género y edad,
calculando gasto total, valor promedio de transacción y frecuencia de
operación, filtrado para grupos demográficos con mínimo 30 clientes activos.
**/

SELECT 
cl.gender,
EXTRACT(YEAR FROM cl.birth_date) AS birth_year,
SUM(tr.amount) AS gasto_total,
AVG(tr.amount) AS gasto_promedio,
COUNT(tr.transaction_id) AS frecuencia,
COUNT(DISTINCT cl.client_id) AS clientes_activos
FROM fintech.clients cl
INNER JOIN fintech.credit_cards cc ON cl.client_id = cc.client_id
INNER JOIN fintech.transactions tr ON cc.card_id = tr.card_id
GROUP BY cl.gender, birth_year
HAVING COUNT(DISTINCT cl.client_id) >= 30;


