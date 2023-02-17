######
# clase_04

#####
## Cargar paquetes
library(tidyverse)

## Cargar datos
cars <- mpg
summary(mpg)


#####
## Graficar (argumentos)

# ggplot(data = DATOS)+ 
# geom_FUNCION(mapping=aes(x = DATOSX, y = DATOSY))

autos <- ggplot(cars) +
  geom_point(mapping = aes(x = displ, y = hwy))
autos

autos1<- ggplot(cars) 
  geom_line(mapping = aes(x = displ, y = hwy))
autos1

## Agregar elementos
autos3 <- ggplot(cars) +
  geom_point(mapping = aes(x = displ, y = hwy))+
  xlab("Volumen de motor") +
  ylab("Millas por galon") +
  ggtitle("Eficiencia de gasolina") +
  theme_minimal() +
  coord_flip()
autos3

## Estética
colores <- ggplot (data = cars) +
  geom_point(mapping = aes(x = displ, hwy,
                         color = class, shape = class))
colores

ggplot(cars) +
  geom_point(mapping = aes(displ,hwy, color = class),
             color = "red")

## Facets
ggplot(cars) +
  geom_point(mapping = aes(displ,hwy, color = class)) +
  facet_wrap(~class, nrow =2)

#####
## Barras
(bat <- ggplot(cars) +
    geom_bar(aes(class)))


cars_count <- cars %>%
  group_by(class) %>%
  summarise(n = n())

(cars_bar <- cars %>%
    group_by(class) %>%
    summarise(n = n()) %>%
    ggplot(aes(class, n))+
    geom_bar(stat = "identity"))

## Barras de proporciones
(bar_prop <- ggplot(cars)+
    geom_bar(aes(class, y =..prop.., group = 1)))

#####
## Regresiones
n <- 1000
x <- rnorm(n)
y <- 4+15*x + rnorm(n, 0, 4)

data <- data.frame(x, y)
modelo_mco <- lm(y ~x,
                 data = data)
modelo_mco

summary(modelo_mco)

# Extrae coeficiente
modelo_mco$coefficients

# end