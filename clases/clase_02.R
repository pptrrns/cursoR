######
# clase_02

#####
## Instalar paquetes
# install.packages("tidyverse")
# install.packages("readxl")

## Cargar paquetes
library(tidyverse)
library(readxl)

## Cargar datos
presidencial <-  readxl::read_excel("/Users/jtorrensh/Documents/GitHub/cursoR/data/presidencia.xlsx")
summary(presidencial)

presidencial <-  readxl::read_excel("/Users/jtorrensh/Documents/GitHub/cursoR/data/presidencia.xlsx", skip = 4) # quitamos los primeros cuatro renglones con skip = 4
summary(presidencial)

## Limpiar base de datos
presidencial <-  presidencial %>%
  rename(votos = TOTAL_VOTOS_CALCULADOS,
         lisnom = LISTA_NOMINAL_CASILLA)

presidencial <-  presidencial %>% 
  mutate(participacion = votos/lisnom) # crear nuevas variables

presidencial$indep <-  presidencial$CAND_IND_01 + presidencial$CAND_IND_02 # otra forma de agregar variables

#####
## Variables dummies
presidencial <- presidencial %>%
  mutate(rural = ifelse(CASILLA == "Rural" | is.na(CASILLA) == T,1,0))
  sum(presidencial$rural) # para contar casillas rurales

#####
## filter()
### ejercicio con filtro para candidatos independientes, en distritos rurales y con participación >= 0.5
independientes <- presidencial %>%
  filter(CAND_IND_01 > 0 | CAND_IND_02 > 0) # filtro condicional con o

independientes <- independientes %>%
  filter(participacion >= 0.5 & rural == 1) # filtro condicional con y

sum(independientes$rural) # contar casillas dele ejercicio anterior

independientes <- independientes %>%
  filter(participacion >= 0.5 & rural == 1) %>%
  group_by(NOMBRE_DISTRITO)  %>% # contar distritos del ejercicio anterior
  summarise()

## select()
# starts_with(), ends_with(), contains(), num_range(), everything()
morena <- presidencial %>%
  select(CLAVE_CASILLA, NOMBRE_ESTADO, contains("MORENA"))

sum(morena$MORENA, na.rm = TRUE) # sumar omitiendo na

rm(list = ls()) # limpiar environment

#####
## Concatenar
# ejercicio votos pan
presidencial <-  readxl::read_excel("/Users/jtorrensh/Documents/GitHub/cursoR/data/presidencia.xlsx", skip = 4)

PAN <-  presidencial %>%
  rename(votos = TOTAL_VOTOS_CALCULADOS) %>%
  filter(NOMBRE_ESTADO == "GUANAJUATO")  %>%
  mutate(pan_ = PAN / votos) %>%
  filter(pan_ >= 0.5)

rm(list = ls()) # limpiar environment

#####
## group_by
presidencial <-  readxl::read_excel("/Users/jtorrensh/Documents/GitHub/cursoR/data/presidencia.xlsx", skip = 4)

presidencial <- presidencial %>%
  group_by(NOMBRE_ESTADO) %>%
  mutate(mean_morena = mean(MORENA, na.rm = TRUE))

rm(list = ls()) # limpiar environment

## sumarise()
presidencial <-  readxl::read_excel("/Users/jtorrensh/Documents/GitHub/cursoR/data/presidencia.xlsx", skip = 4)

sum_estados <-  presidencial %>%
  group_by(NOMBRE_ESTADO) %>%
  summarise(
    pan = sum(PAN, na.rm = TRUE),
    pri = sum(PRI, na.rm = TRUE)
  )

## rowwise() sumar horizontalmente
presidencial <-  presidencial %>%
  rowwise() %>% 
  mutate(total_morena = sum(c_across(contains("MORENA")))
         )

## case_when()
presidencial <-  presidencial %>%
  mutate(participacion = TOTAL_VOTOS_CALCULADOS / LISTA_NOMINAL_CASILLA) %>%
  mutate(
    participativo = case_when(
      participacion < 0.3 ~ "poco",
      participacion >= 0.3 & participacion < 0.6 ~ "medio",
      participacion >= 0.6 ~ "alto"
    )) %>%
filter(participativo == "poco")

#####
## Serie de tiempo
lag() # recrea el vector, pero empezando en un periodo rezagado
lead() # recrea el vector, pero empezando en un periodo adelante

# end