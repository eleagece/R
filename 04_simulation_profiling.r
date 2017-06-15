#=================================#
# 4. Simulacion y profiling con R #
#=================================#

#+------------------------------------------------------------------------------------------+
#| Funciones que dan informacion
#+------------------------------------------------------------------------------------------+
str(str)
str(lm)
str(ls)
x<-rnorm(100,2,4)
summary(x)
str(x)
f<-gl(40,10)
str(f)
summary(f)
library(datasets)
head(airquality)
str(airquality)
m<-matrix(rnorm(100),10,10)
str(m)
m[,1]
s<-split(airquality,airquality$Month)
str(s)

#+------------------------------------------------------------------------------------------+
#| Generacion de numeros aleatorios
#+------------------------------------------------------------------------------------------+
#'rnorm' genera variables aleatorias normales segun su media y desviacion estandar
#'dnorm' evalua la densidad de la probabilidad
#'pnorm' evalua la distribucion acumulada de una distribucion normales
#'rpois' genera variables de poisson con un ratio dado
#
#d densidad
#r generacion aleatoria
#p distribucion acumulativa
#q funcion quantil?
#
#distribucion normal
set.seed(1) #genera los aleatorios sobre un numero concreto
x<-rnorm(10)
x<-rnorm(10,20,2)
summary(x)
#distribucion poisson
rpois(10,1)
rpois(10,2)
rpois(10,20)
ppois(2,2) #Pr(x<=2)
ppois(4,2) #Pr(x<=4)
ppois(6,2) #Pr(x<=6)