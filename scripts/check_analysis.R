# Ejecutar desde la raíz: Rscript scripts/check_analysis.R
library(dplyr)
library(tidyr)
library(readxl)
library(janitor)

# Extraer y ejecutar los bloques de preparación evita duplicar los datos del post.
chunks <- function(path) {
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  starts <- grep("^```\\{r", lines)
  lapply(starts, function(start) {
    finish <- start + which(lines[(start + 1):length(lines)] == "```")[1]
    lines[(start + 1):(finish - 1)]
  })
}
hanta <- new.env()
eval(parse(text = chunks("posts/hantavirus/index.qmd")[[2]]), envir = hanta)
stopifnot(all(hanta$casos_anuales$fallecidos <= hanta$casos_anuales$casos),
          all(is.na(hanta$casos_anuales$letalidad[hanta$casos_anuales$casos == 0])))

mortalidad <- new.env()
previous <- getwd()
preparacion <- chunks("posts/mortalidad/index.qmd")[[2]]
setwd("posts/mortalidad")
eval(parse(text = preparacion), envir = mortalidad)
setwd(previous)
stopifnot(!anyDuplicated(mortalidad$POBLACION_REGIONAL[c("ANIO", "REGION_SANITARIA")]))

# Verificar que el agregado regional suma cada población municipal una sola vez.
esperado <- mortalidad$POBLACION |>
  semi_join(mortalidad$municipios_region, by = "MUNICIPIO_NOMBRE") |>
  group_by(ANIO) |>
  summarise(total = sum(POBLACION), .groups = "drop")
observado <- mortalidad$POBLACION_REGIONAL |>
  group_by(ANIO) |>
  summarise(total = sum(POBLACION), .groups = "drop")
stopifnot(isTRUE(all.equal(esperado, observado)))
message("Validaciones epidemiológicas completadas.")
