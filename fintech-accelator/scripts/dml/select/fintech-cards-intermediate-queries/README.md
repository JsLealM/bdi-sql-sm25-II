# Taller de Análisis Financiero con SQL: Técnicas Avanzadas de Consulta para Sistemas de Datos Financieros

## Introducción

Bienvenido al Taller de Análisis de Datos Financieros. Esta sesión de laboratorio está diseñada para desarrollar competencias en técnicas de consulta SQL específicamente adaptadas para sistemas de transacciones financieras. Los participantes extraerán y analizarán información valiosa de la base de datos `fintech_cards`, desarrollando competencias en manipulación de datos y análisis financiero.

## Requisitos Previos

- Comprensión básica de sintaxis SQL y conceptos de bases de datos
- PostgreSQL instalado (versión 13 o superior recomendada)
- Credenciales de acceso a la base de datos `fintech_cards`

## Configuración del Entorno de Trabajo

1. Acceda al entorno PostgreSQL utilizando pgAdmin o la interfaz de línea de comandos:

```sql
psql -U fc_admin -d fintech_cards
```

2. Cree un nuevo archivo de script en el directorio del proyecto designado:
   `fintech-accelator/scripts/dml/insert/02-insert-clients-transactions.sql`

3. Copie el script de población de datos de muestra desde el repositorio:
   [Script de Población de Datos](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/insert/02-insert-clients-transactions.sql)

4. Ejecute el script para poblar la base de datos con datos de prueba necesarios para los ejercicios del taller.

## Módulos del Taller

### Módulo 1: Operaciones Avanzadas de Join ([`01-basic-joins.sql`](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/select/fintech-cards-intermediate-queries/01-basic-joins.sql))

Cree un archivo llamado `01-basic-joins.sql` implementando los siguientes objetivos de consulta:

1. **Consulta de Relación de Entidades**:  
   Construya una vista integral de transacciones con detalles de cliente asociados, incluyendo nombre del cliente, monto de la transacción, nombre del comercio y método de pago.

2. **Análisis de Relación Cliente-Tarjeta**:  
   Genere una lista completa de clientes y sus tarjetas de crédito asociadas, asegurando la inclusión de clientes sin tarjetas registradas.

3. **Análisis de Transacciones Comerciales**:  
   Desarrolle una consulta para mostrar todas las ubicaciones comerciales y sus transacciones asociadas, incluidas las ubicaciones sin actividad de transacciones registrada.

4. **Distribución Geográfica de Franquicias**:  
   Cree una consulta para analizar franquicias y sus países de operación, incluidas franquicias sin asociaciones de país y países sin franquicias activas.

5. **Detección de Patrones de Transacciones Recurrentes**:  
   Implemente una consulta self-join para identificar pares de transacciones del mismo cliente en la misma ubicación comercial en diferentes fechas, revelando comportamientos de compra recurrentes.

### Módulo 2: Análisis de Agregación Financiera ([`02-aggregation-functions.sql`](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/select/fintech-cards-intermediate-queries/02-aggregation-functions.sql))

Cree un archivo llamado `02-aggregation-functions.sql` con las siguientes consultas analíticas:

1. **Análisis de Gastos del Cliente**:  
   Calcule los montos totales de transacciones por cliente dentro del período de tres meses más reciente, mostrando identificación del cliente y gasto total.

2. **Distribución de Valor de Transacción**:  
   Determine los valores promedio de transacciones agrupados por categoría de comercio y método de pago para identificar patrones de gasto en diferentes tipos de establecimientos.

3. **Distribución de Emisión de Tarjetas**:  
   Cuantifique las tarjetas de crédito emitidas por cada institución financiera, categorizadas por franquicia, para determinar la penetración de mercado por tipo de tarjeta.

4. **Análisis de Límites de Gasto**:  
   Identifique los montos de transacción mínimos y máximos para cada cliente junto con las fechas correspondientes para establecer patrones de rango de gasto.

### Módulo 3: Técnicas Avanzadas de Agrupación y Filtrado ([`03-group-by-clauses.sql`](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/select/fintech-cards-intermediate-queries/03-group-by-clauses.sql))

Cree un archivo llamado `03-group-by-clauses.sql` con las siguientes consultas analíticas:

1. **Identificación de Clientes de Alto Valor**:  
   Calcule los totales de gastos de seis meses por cliente, filtrando aquellos que superan los $7,750,424,420,346.32 (~7.75 billones), incluyendo identificación completa del cliente y frecuencia de transacciones.

2. **Análisis de Rendimiento de Categoría Comercial**:  
   Analice categorías comerciales por valor promedio de transacción por país, filtrando categorías con transacciones promedio superiores a $5,497,488,250,176.02 (~5.50 billones) y mínimo 50 operaciones.

3. **Análisis de Rechazo de Transacciones**:  
   Determine franquicias de tarjetas con tasas elevadas de rechazo de transacciones por país, mostrando franquicia, país y porcentaje de rechazo, filtrado para tasas superiores al 5% con mínimo 100 intentos de transacción.

4. **Distribución Geográfica del Método de Pago**:  
   Analice los métodos de pago dominantes por ciudad, incluyendo nombre del método, ciudad, país y volumen de transacciones, filtrado para métodos que representan más del 20% del volumen de transacciones de una ciudad.

5. **Análisis de Patrones de Gasto Demográfico**:  
   Evalúe el comportamiento de compra en demografías de género y edad, calculando gasto total, valor promedio de transacción y frecuencia de operación, filtrado para grupos demográficos con mínimo 30 clientes activos.

### Módulo 4: Procesamiento de Fechas ([`04-date-time-processing.sql`](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/select/fintech-cards-intermediate-queries/04-date-time-processing.sql))

Cree un archivo llamado `04-date-time-processing.sql` con las siguientes consultas analíticas:

1. **Análisis de Tarjetas Vencidas**:  
   Cree una consulta que muestre todos los clientes que tienen tarjetas de crédito vencidas a la fecha actual, incluyendo el nombre del cliente y la fecha de vencimiento de la tarjeta.

2. **Antigüedad de Transacciones**:  
   Desarrolle una consulta que calcule la antigüedad de todas las transacciones completadas, ordenándolas desde la más reciente hasta la más antigua, mostrando el monto, el nombre del cliente y la antigüedad.

3. **Análisis de Transacciones por Mes**:  
   Genere un informe que muestre el total de transacciones agrupadas por mes, incluyendo el monto total y el número de transacciones por mes.

4. **Transacciones en las Últimas 24 Horas**:  
   Elabore una consulta que identifique las transacciones realizadas en las últimas 24 horas, mostrando los detalles del cliente, el comercio y el método de pago utilizado.

5. **Patrones de Gasto por Día de la Semana**:  
   Construya un análisis que muestre el promedio de gasto por día de la semana, agrupando las transacciones por el día y ordenando por el promedio de gasto de mayor a menor.

### Módulo 5: Procesamiento de Cadenas de Texto ([`05-string-processing.sql`](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering/blob/main/content/fintech-accelator/scripts/dml/select/fintech-cards-intermediate-queries/05-string-processing.sql))

Cree un archivo llamado `05-string-processing.sql` con las siguientes consultas analíticas:

1. **Normalización de Nombres**:  
   Cree una consulta que muestre los nombres de los clientes y nombres de comercios en mayúsculas, junto con el monto de sus transacciones más recientes, ordenados por monto.

2. **Búsqueda de Transacciones por Categoría**:  
   Desarrolle una consulta que busque transacciones en comercios cuya categoría contenga la palabra "Boutique", mostrando el nombre del cliente, fecha y monto.

3. **Formateo de Nombres Completos**:  
   Genere un listado de tarjetas que muestre un campo con el nombre completo del cliente y el estado de su tarjeta.

4. **Identificación de Correos Electrónicos Cortos**:  
   Elabore una consulta que identifique clientes con direcciones de correo electrónico cortas (menos de 15 caracteres), mostrando el nombre del cliente y la longitud del correo.

5. **Análisis de Dominios de Correo**:  
   Construya un análisis que extraiga el dominio del correo electrónico de cada cliente, agrupando por dominio y contando cuántos clientes usan cada servicio de correo.

## Entregables

Para cada desafío analítico, los participantes deben:

1. Desarrollar la consulta SQL implementando el objetivo analítico descrito
2. Ejecutar la consulta y validar la integridad del resultado

## Enfoque Metodológico

Para un diseño óptimo de consultas:
1. Primero identifique las relaciones de tabla necesarias
2. Determine las columnas de salida requeridas
3. Establezca condiciones de filtrado apropiadas
4. Implemente mecanismos adecuados de agrupación y ordenación

## Resultados de Aprendizaje

Al completar este taller, los participantes habrán desarrollado la capacidad de:

* Identificar patrones y comportamientos de gasto de clientes
* Implementar técnicas de detección de anomalías para posible actividad fraudulenta
* Realizar análisis de tendencias de transacciones geográficas y demográficas
* Generar conocimientos basados en datos para optimizar estrategias financieras

---

*Repositorio: [SQL-101-Mastering](https://github.com/Doc-UP-AlejandroJaimes/sql-101-mastering)*
