# Estimación de parámetros en cromatografía de afinidad en membranas

Este repositorio contiene el desarrollo computacional y resultados asociados a mi tesis, enfocada en la estimación de parámetros en un modelo de cromatografía de afinidad en membranas.

## Objetivo

Estudiar la estimación de los parámetros adimensionales $(m,n,r)$ a partir de curvas de elución experimentales, analizando la influencia de distintos métodos de optimización y evaluando la robustez mediante datos sintéticos.

## Metodología

El trabajo integra:

- Modelación matemática del proceso cromatográfico
- Resolución numérica del problema directo
- Formulación del problema inverso como mínimos cuadrados no lineales
- Comparación de métodos de optimización (lsqnonlin, fminsearch, Pattern Search, Algoritmo Genético)
- Generación y análisis de datos sintéticos
- Evaluación de incertidumbre mediante intervalos percentiles y cobertura

## Estructura del repositorio

- `codigos/`: scripts de simulación, optimización y análisis
- `modificables/`: scripts que se deben modificar al cambiar bases de datos
- `main/`: scripts de los distintos métodos de optimización utilizados
- `datos/`: datos experimentales y/o procesados


## Principales resultados

- El modelo reproduce adecuadamente las curvas de elución
- Existe no unicidad en la estimación de parámetros
- La elección del método de optimización influye significativamente
- Los datos sintéticos permiten evaluar robustez e incertidumbre

## Tecnologías utilizadas

- MATLAB
- LaTeX


## Uso del código

Para ejecutar el modelo, se debe trabajar desde la carpeta `main_models`, donde se encuentran los distintos métodos de optimización implementados.

### Métodos disponibles

Dentro de esta carpeta se pueden ejecutar los siguientes algoritmos:

- `fminsearch`
- Algoritmo Genético (AG)
- Pattern Search (PS)
- `lsqnonlin` (formulación vectorial)
- `lsqnonlin` escalar

Se debe elegir el método que se desea utilizar según el análisis a realizar (datos experimentales o sintéticos).

---

### Selección de base de datos

El modelo utiliza dos bases de datos experimentales:

- **HB → base 2**
- **LYS → base 11**

Para seleccionar la base de datos, se debe modificar el archivo:

`carga_datos_new_model_2025_df`


---

### Datos sintéticos

Para trabajar con datos sintéticos, se debe modificar el archivo:

`carga_datos_new_model_2025_df_Synteticos`


---

### Importante

- Antes de ejecutar cualquier método, se debe seleccionar la base de datos correspondiente.
- El mismo procedimiento aplica tanto para datos experimentales como sintéticos.
- `carga_datos_new_model_2025_df` y `carga_datos_new_model_2025_df_Synteticos` se encuentran en la carpeta de `modificables`
- No es necesario modificar otros archivos.














