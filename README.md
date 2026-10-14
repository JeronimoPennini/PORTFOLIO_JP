# Portfolio de Jerónimo Pennini

Sitio de análisis epidemiológicos construido con R y Quarto. Las fuentes son los
archivos `.qmd`; GitHub Pages sirve la salida generada en `docs/`.

## Preparar el entorno

Instalar Quarto y la versión de R indicada en `renv.lock`. Desde la raíz del proyecto:

```r
install.packages("renv", repos = "https://cloud.r-project.org")
renv::restore()
```

## Comprobar y publicar cambios

```sh
Rscript scripts/check_analysis.R
quarto render --execute
python scripts/check_site.py
```

La renderización completa con `--execute` recalcula los análisis, incluyendo cambios
en Excel, GeoJSON y dependencias. `freeze: auto` permite reutilizar resultados al
trabajar, pero no sustituye la comprobación completa antes de publicar. Revisar los
gráficos y mapas en `quarto preview`, incluyendo una pantalla estrecha, y guardar
fuentes, resultados `_freeze/` y salida `docs/` en el mismo commit.

Los datos ilustrativos se identifican en cada publicación y no constituyen
estadísticas oficiales. Las coordenadas del mapa de DIH representan localidades,
no domicilios de dispositivos ni un inventario oficial.

`posts/cancer/provincias.geojson` conserva la geometría de Georef
(`https://apis.datos.gob.ar/georef/api/provincias.geojson`, descargada el 14/10/2026).
El mapa de DIH usa mosaicos de OpenStreetMap y requiere conexión para su fondo.
GitHub Actions comprueba las referencias del HTML en cada push y pull request.

Para actualizar dependencias deliberadamente: `renv::snapshot(type = "all")` tras
verificar el renderizado. No editar manualmente los HTML de `docs/`.
