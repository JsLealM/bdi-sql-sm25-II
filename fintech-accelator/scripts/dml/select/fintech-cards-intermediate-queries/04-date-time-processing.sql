-- DATES PROCESSING APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 16/05/2025

/**
1. Análisis de Tarjetas Vencidas:
Cree una consulta que muestre todos los clientes que tienen
tarjetas de crédito vencidas a la fecha actual, 
incluyendo el nombre del cliente y la fecha de vencimiento de la tarjeta.
**/

/**
2. Antigüedad de Transacciones:
Desarrolle una consulta que calcule la antigüedad
de todas las transacciones completadas,
ordenándolas desde la más reciente hasta la más antigua,
mostrando el monto, el nombre del cliente y la antigüedad.
**/

/**
3. Análisis de Transacciones por Mes:
Genere un informe que muestre el total de transacciones agrupadas por mes,
incluyendo el monto total y el número de transacciones por mes
**/
SELECT
	TO_CHAR(DATE_TRUNC('month', transaction_date), 'Month') as month,
	DATE_TRUNC('month', transaction_date) AS month_transaction,
	COUNT(*) total_transactions,
    SUM(amount) total_amount
   
FROM 
    fintech.transactions
GROUP BY 
    month_transaction, month
ORDER BY 
    month_transaction;

/**
4. Transacciones en las Últimas 24 Horas:
Elabore una consulta que identifique las transacciones realizadas
en las últimas 24 horas, mostrando los detalles del cliente, el comercio
y el método de pago utilizado.
**/

/**
5. Patrones de Gasto por Día de la Semana:
Construya un análisis que muestre el promedio de gasto 
por día de la semana, agrupando las transacciones por el día 
y ordenando por el promedio de gasto de mayor a menor.
**/