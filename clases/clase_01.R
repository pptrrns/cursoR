######
# clase_01

#####
## Creación de variables

a <- 6 # definir una variable
b <- 9
c <- 3

### Variables numéricas
x <- 5
y <-  3

w <- (x + y) # definir una variable en función de otras variables
sqrt(w) # raíz cuadrada

### Variables de caracteres
texto <-  "José"
num <- "9"

as.numeric(num) + a

### Operadores lógicos (TRUE or FALSE) con variables
a >= 7

#### Otros operadores lógicos

# & intersección de conjunto  (y en lógica)
# | unión de conjuntos (o en lógica)
# == igual (si solo ponemos un = estaríamos reasignando el valor de la variable)
# =! distinto
# %in%, está en, pertenece a
d <-  (1:10)
8 %in% d
# ! complemento

a == 5 & b > 1 # da como resultado TRUE o FALSE

### RStudio define qué tipo de dato es la variable texto
is.character(texto)
is.numeric(a)

#### Remover variables
rm(a) # solo una variable
rm(list = ls()) # todas las variables

#####
## Vectores

vector <-  c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) # c es por conjunto
vector_1 <- c(11, 12, vector)
vector_texto <-  c("ps5", "Xbox")

vector_2 <- seq(from = 1, to = 90) # vector del 1 al 90
vector_2 <- seq(1, 90, by = 10) # vector_3 con breaks by 3
length(vector_2) # largo del vector_2
length(vector_texto)

vector_3 <- seq(222, 9901, by = 3) # vector_3 con breaks by 3

vector_texto[2] # posición dos del vector
vector_1[c(1,2)] # posición 1 y 2 del vector_1

vector_4 <- (1:35)

### Slices
vector_4[4:9] # de la posición 4 hasta la 9
vector_4[c(4,10:15)] # posición 4 y de la 10 a la 15

e <- (1:4)
f <- c(TRUE, TRUE, FALSE, FALSE)
f[e > 2] # posición 3 y 4 del vector f

#### Operadores lógicos con vectores
vector_4[vector_4 > 7] # los datos del vector_4 mayores a 7

##### Residuo
# %%
90 %%2 # residuo es 0, por lo que 90 es par

length(vector_4[c(vector_4 > 5 & vector_4%%2 == 0)]) # números en vector_4 mayores a 5 y con residuo 0 al dividir entre dos, es decir, números pares

vector_5 <- seq(345, 967, by = 2)
promedio <- mean(vector_5[vector_5 > 503 & vector_5%%3 == 0]) # promedio

#### Operaciones con vectores
r <- (1:10)
r ^ 2 # elevar el vector r al cuadrado
r + r # suma
mean(r) # promedio
max(r) # valor máximo
min(r) # valor mínimo
sd(r) # desviación estándar
sqrt(var(r)) # desviación estándar
var(r) # varianza
median(r) # mediana

#### Ordenar los vectores
vector_7 <- seq(4,99,2)
sort(vector_7, TRUE) # ordenar el vector de mayor a menor
sort(vector_7, FALSE) # ordenar el vector de menor a mayor

rep(vector_7, 2) #replica el vector_7 dos veces

### Crear grupos y muestras aleatorias
bolitas <-  c(rep("azul", 3), rep("verde", 2), rep("roja", 4)) # creamos un conjunto
bolitas
sample(bolitas, 2, TRUE) # muestra aleatoria de un vector con reemplazo

set.seed(5324) # la misma aleatoriedad // replicabilidad
sample(bolitas, 2, TRUE) # correr esta línea con el código de arriba

#### ejercicio - flip a coin
set.seed(10) # la misma aleatoriedad // replicabilidad
flip_coin <- c("águila","sol") # flip_coin
sample(flip_coin, 10, TRUE) # muestra aleatoria de un vector con reemplazo

flip_coin <- c("águila","sol") # flip_coin
sample(flip_coin, 10, TRUE) # muestra aleatoria de un vector con reemplazo

#### ejercicio 2
##### mismo caso que el ejercicio anterior, pero para saber cuántas veces salió águila
ejercicio <-  sample(flip_coin, 10, TRUE)
ejercicio[ejercicio == "águila"]
ejercicio == "águila"

##### mismo caso que el ejercicio anterior, pero para saber cuántas veces salió águila y en qué posiciones
flip_coin_1 <-  sample(flip_coin, 10, TRUE)
seq(1:10)[flip_coin_1 == "águila"]
length(seq(1:10)[flip_coin_1 == "águila"])

rm(list = ls())

#####
## Dataframe

### Operaciones
rt <-  seq(10)
resultado <-  sample(c("águila", "sol"), 10, TRUE)
df <-  data.frame(rt, resultado)

mean(df$rt, na.rm = TRUE) # promedio de la variable rt omitiendo los valores NA
  # usamos $ después de indicar el dataframe, en este caso "df"

n <-  c(1, 2, 3, 4, 5, NA)
mean(n, na.rm = TRUE) # removemos los NA para sacar el promedio

### ejercicio
#### construir un dataframe con las variables carrera, género, 
n <- 1000
carrera <- sample(c("Economía", "C. Pol", "RR.II", "Matemáticas"), n, TRUE) # con sample R aleteoriza
género <- sample(c("Hombre", "Mujer", "Prefiere no especificar"), n, TRUE)
promedio <-  round(runif(n, 4, 10), 2)
data <- data.frame(carrera, género, promedio)
# con round redondeamos y ponemos dos dígitos en el promedio
# con runif hacemos n números aleatorios con valor mínimo 4 y 10

data$mención_esp <- data$promedio >= 8.5 & data$promedio < 9 # crear variable con condiciones
data$mención_hon <- data$promedio >= 9 # crear variable con condiciones

length(data$promedio[data$promedio >= 8.5 & data$promedio < 9]) # número de promedio con mención
mean(data$promedio) # promedio de los 1000 alumnos del dataframe

rm(list = ls())
# end