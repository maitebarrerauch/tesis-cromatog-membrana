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


