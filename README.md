# 📊 Grupo 1 - Diplomado Power BI PUCP

Evidencias del trabajo de Power BI - Diplomado en Data Visualization, PUCP

## 📝 Descripción General

Los reportes generados en **Power BI** representan el resultado del análisis de 
**deserción estudiantil**, transformando datos almacenados en SQL Server (Azure, 
schema G1) en visualizaciones claras orientadas a la toma de decisiones académicas. 
El modelo se construyó bajo un esquema de estrella, priorizando el rendimiento y la 
claridad en el análisis.

## ⚙️ Principales Características

- 🗂️ **Modelo de datos en estrella**: conexión a base de datos SQL Server en Azure, 
estructurando tablas de hechos y dimensiones para optimizar el análisis.
- 📊 **Medidas DAX personalizadas**: cálculo de la Tasa de Deserción y el Impacto 
Económico mediante funciones como LOOKUPVALUE, vinculando métricas con resultados 
académicos.
- 📅 **Tabla Calendario dinámica**: construida en DAX para permitir análisis temporal 
y comparaciones por periodo.
- 🔍 **Filtros dinámicos e interacción cruzada**: los usuarios pueden explorar los 
datos por facultad, periodo u otros criterios relevantes.
- ✅ **Verificación con SQL**: cada página del reporte fue validada con consultas 
SQL para garantizar la precisión de los datos mostrados.

## 🚀 Impacto

Este proyecto convierte los datos académicos de deserción en un soporte estratégico 
para la toma de decisiones institucionales. El análisis permite identificar patrones 
de riesgo y su impacto económico, contribuyendo a mejorar la retención estudiantil.

## 🛠️ Herramientas Utilizadas

- Power BI Desktop
- SQL Server (Azure)
- DAX (Data Analysis Expressions)
- Power BI Service

## 🧮 Medidas DAX — Inteligencia Analítica

### 🔴 Tasa de Deserción
Proporción de deserciones sobre el total de matrículas. Resultado global: 5.12%

```DAX
DIVIDE(COUNTROWS('G1 DESERCION'), COUNTROWS('G1 MATRICULA'), 0)
```

### 🔵 Tasa Deserción Año Anterior
Compara el mismo semestre del año anterior. Ej: 2025-2 vs 2024-2.

```DAX
CALCULATE([Tasa de Desercion], DATEADD(Calendario[Date], -12, MONTH))
```

### 🟢 Variación Tasa Deserción
Diferencia en puntos porcentuales respecto al mismo período del año anterior.

```DAX
[Tasa de Desercion] - [Tasa Desercion Año Anterior]
```

### 🟠 Tasa Deserción Semestre Anterior
Compara el semestre inmediatamente anterior. Ej: 2025-2 vs 2025-1.

```DAX
CALCULATE([Tasa de Desercion], DATEADD(Calendario[Date], -6, MONTH))
```

## 🔎 Hallazgos Principales

*Insights clave del análisis de deserción estudiantil PUCP*

### 🔴 8.61% — Pico máximo de deserción (2020-2)
Impacto COVID-19: la deserción se duplicó respecto al mismo semestre del año 
anterior (+106%)

### 🔵 5.12% — Tasa general de deserción (Global)
6,682 desertores sobre 130,500 matrículas registradas en el período 2019-2025

### 🟢 3.93% — Mínimo histórico reciente (2024-2)
La tendencia post-COVID muestra una mejora sostenida, con la tasa más baja 
registrada en 2024-2

### 🟡 +27% — Repunte reciente vs año anterior (2025-2)
2025-2 muestra una tasa del 5.00% vs 3.93% del 2024-2, señal de alerta para 
el siguiente período

## 📸 Evidencias del Proyecto

### Modelo de Datos
![Modelo de datos](imagenes/modelo-datos.png)



