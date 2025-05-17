-- DATES PROCESSING APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 16/05/2025

/**
1. Normalización de Nombres:
Cree una consulta que muestre los nombres de los clientes y nombres de comercios
en mayúsculas, junto con el monto de sus transacciones más recientes, 
ordenados por monto.
**/

/**
2. Búsqueda de Transacciones por Categoría:
Desarrolle una consulta que busque transacciones en comercios 
cuya categoría contenga la palabra "Boutique", 
mostrando el nombre del cliente, fecha y monto.
**/

/**
3. Formateo de Nombres Completos:
Genere un listado de tarjetas que muestre un campo con el nombre 
completo del cliente y el estado de su tarjeta.
**/

/**
4. Identificación de Correos Electrónicos Cortos:
Elabore una consulta que identifique clientes con direcciones
de correo electrónico cortas (menos de 15 caracteres), 
mostrando el nombre del cliente y la longitud del correo.
**/


/**
5. Análisis de Dominios de Correo:
Construya un análisis que extraiga el dominio del correo electrónico
de cada cliente, agrupando por dominio y contando 
cuántos clientes usan cada servicio de correo.
**/

-- SPLIT_PART(email,'@',2) as email_domain
SELECT 
	SPLIT_PART(email,'@',2) AS email_domain,
    COUNT(*) AS total_service_domain
FROM 
    fintech.clients
GROUP BY 
    email_domain
ORDER BY 
    total_service_domain DESC;