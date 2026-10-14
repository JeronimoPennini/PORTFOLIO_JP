# UTF-8 en Windows para nombres de columnas con tildes.
if (.Platform$OS.type == "windows") {
  invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8"))
}
