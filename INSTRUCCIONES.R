# library(quarto)
# 
# #Para crear un nuevo post
# quarto::new_blog_post("Bienvenida")
# 
# #CARGAR A GITHUB
# 
# # Configurar Git
# # Instalar un paquete de R que nos ayudará:
#   
#   install.packages("usethis")
# 
# # Configura tu cuenta y crea un token para autenticarla (en lugar de usar contraseñas)
# 
# usethis::use_git_config(user.name = "bastianolea", user.email = "bastianolea@gmail.com")
# usethis::create_github_token()
# 
# # Copia el token que te entrega, e ingrésalo:
#   
#   gitcreds::gitcreds_set()
# 
# # Confirmar la situación de Git en tu equipo:
#   
#   usethis::git_sitrep()


#EDICION DE TEXTO
## Subtítulos
### Subsubtítulos
**negrita**
  *itálica* o _itálica_
<u>subrayado</u>
  ~~tachado~~
  `código`
[Enlaces](http://www.enlace.cl)
Agregar una nota al pie[^1].
[^1]: Esta es una nota al pie


#PARA AGREGAR CAMBIOS 
#EN LA TERMINAL
git add .
git commit -m "cambios en el blog"
git push


git branch -m Egresos-Hospitalarios-SM main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a

git reset --mixed origin/main



# Remover del índice sin borrar el archivo local
git rm --cached docs/index.xml
git rm --cached -r _freeze/
  git rm --cached -r docs/posts/mortalidad/
  
  # Commitear la limpieza
  git add .gitignore
git commit -m "Remover archivos pesados del tracking"
git push
