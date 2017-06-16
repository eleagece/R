#===================#
# 3. Loop functions #
#===================#

#+------------------------------------------------------------------------------------------+
#| 'lappply' aplica una funcion a todos los elementos que se pasen y devuelve
#| el resultado en una lista
#+------------------------------------------------------------------------------------------+
#ej1. aplica la media a ttyodas los elementos de la lista y lo devuelve en otra
#lista con los mismos nombres
l1<-list(a=1:5,b=rnorm(10))
lapply(l1,mean) 
l1<-list(a=1:4,b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
lapply(l1,mean) 
#ej2. aplica runif (random uniform) a cada numero de la secuencia en x y
#devuelve una lista con lo que genera entre 0 y 1 (default) o entre 0 y 10
l2<-1:4
lapply(l2,runif)
l2<-1:4
lapply(l2,runif,min=0,max=10)
#ej3. uso de funcion anonima para sacar la primera columna de cada matriz.
#la funcion no tiene nombre y solo funciona en el ambito en que se usa
l3<-list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
lapply(l3,function(elt) elt[,1])
rm(l1,l2,l3)

#+------------------------------------------------------------------------------------------+
#| 'sappply' aplica una funcion a todos los elementos que se pasen y devuelve
#| el resultado en una lista EXCEPTO si lo que puede devolver es simplficable
#| (en un vector o una matriz)
#+------------------------------------------------------------------------------------------+
#ej1. aplica la media a todas los elementos de la lista y lo devuelve en otra
#un VECTOR
l1<-list(a=1:5,b=rnorm(10))
sapply(l1,mean) 
l1<-list(a=1:4,b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
sapply(l1,mean)
rm(l1)

#+------------------------------------------------------------------------------------------+
#| 'apply' 
#+------------------------------------------------------------------------------------------+
#ej1. aplica la media a las COLUMNAS (eligiendo MARGEN 2) o la suma de
#las FILAS (eligiendo MARGEN 1)
m1<-matrix(rnorm(200),20,10)
apply(m1,2,mean)
apply(m1,1,sum)
#importante saber que hay funciones que hacen sumas y medias de forma pre-
#determinada sin necesidad de usar 'apply', ademas son mas rapidas
#rowSums=apply(x,1,sum)
#rowMeans=apply(x,1,mean)
#colSums=apply(x,2,sum)
#colMeans=apply(x,2,mean)
#ej2. aplica percentiles a las COLUMNAS (eligiendo MARGEN 1) pero solo saca
#percentil 25 y 75 (si no especifica se muestran cada 25)
m2<-matrix(rnorm(200),20,10)
apply(m2,1,quantile,probs=c(0.25,0.75))
#ej3. crea un array de tres dimensiones (podriamos decir que son 10 matrices
#una encima de otra) y las rellena con valores aleatorios. Hace la media
#filtrando por filas y columnas (margen 1 y 2)
a1<-array(rnorm(2*2*10),c(2,2,10)) #array(datos_que_val_array,indices_para_cada_dimension)
apply(a1,c(1,2),mean)
rm(m1,m2,a1)

#+------------------------------------------------------------------------------------------+
#| 'mapply' (multiple apply) aplica funciones en paralelo a distintos sets de datos
#+------------------------------------------------------------------------------------------+
#ej1. aplica la funcion 'rep' con los argumentos en orden
mapply(rep,1:4,4:1) 
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1)) #lo mismo pero con una list
#ej2. igual que ej1. usando c(...)
mapply(rep,c(1,3,5,7),c(2,3,2,3)) 
list(rep(1,2),rep(3,3),rep(5,2),rep(7,3))
#ej3. aplica la funcion que hemos creado ('noise') segun los argumentos 
noise<-function(n,mean,sd) #numero de observaciones, media y desviacion tipica
	{
	rnorm(n,mean,sd)
	}
mapply(noise,1:5,1:5,2)
list(noise(1,1,2),noise(2,2,2),noise(3,3,2),noise(4,4,2),noise(5,5,2)) #lo mismo pero con list
rm(noise)

#+------------------------------------------------------------------------------------------+
#| 'tapply' aplica funcion a distintos subsets de datos
#+------------------------------------------------------------------------------------------+
#ej1. aplica a un vector de datos una funcion, pero esta funcion se aplica a cada
#subvector identificado por el factor 'f'
x<-c(rnorm(10),runif(10),rnorm(10,1)) 
f<-gl(3,10) #genera un factor indicando que son 3 niveles de 10 elementos
tapply(x,f,mean) #aplica la media segun los 10 y lo devuelve en vector
tapply(x,f,mean,simplify=FALSE) #lo mismo pero devuelve en lista
rm(x,f)

#+------------------------------------------------------------------------------------------+
#| 'split' corta estructuras de datos. muy util en conjuncion con *apply 
#+------------------------------------------------------------------------------------------+
#ej1. corta el vector de datos en otros tres y los devuelven  en una lista
x<-c(rnorm(10),runif(10),rnorm(10,1)) 
f<-gl(3,10) #genera un factor indicando que son 3 niveles de 10 elementos
split(x,f) #corta el vector en otros tres siguiendo lo que dice el vector 'f'
#ej2. 'lapply'+'split'
lapply(split(x,f),mean)
#ej3. 'lapply'+'split' en un data frame
library(datasets) #por si no tenemos cargado 'airquality'
head(airquality) #vemos los primeros elementos del data frame
s<-split(airquality,airquality$Month) #corta el data frame por meses
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")])) #halla las medias por columna pero muestra NAs de las que tienen NAs
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm=TRUE)) #halla las medias por columna ignorando NAs
#ej4. 'sapply'+'split' en un data frame
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")])) #halla las medias por columna pero muestra NAs de las que tienen NAs
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm=TRUE)) #halla las medias por columna ignorando NAs
#ej5. 'split' en mas de un nivel
x<-rnorm(10)
f1<-gl(2,5)
f2<-gl(5,2)
f3<-interaction(f1,f2) #ver los 5x2=10 niveles y distribucion en ellos
#1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5 #2 elementos en 1.1, 0 elementos en 2.1, 2 elementos en 1.2...
#Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5
str(split(x,list(f1,f2))) #corta el vector en 10 niveles y reparte los elementos al estilo que vemos en 'interaction'. 'str' muestra la estructura interna del 'split'
#List of 10
# $ 1.1: num [1:2] 1.9666 -0.0371
# $ 2.1: num(0) 
# $ 1.2: num [1:2] 0.112 -1.69
# $ 2.2: num(0) 
# $ 1.3: num -0.265
# $ 2.3: num -0.498
# $ 1.4: num(0) 
# $ 2.4: num [1:2] -1.602 -0.475
# $ 1.5: num(0) 
# $ 2.5: num [1:2] 2.005 -0.547
str(split(x,list(f1,f2),drop=TRUE)) #igual pero eliminando los niveles sin elementos
#List of 6
# $ 1.1: num [1:2] 1.9666 -0.0371
# $ 1.2: num [1:2] 0.112 -1.69
# $ 1.3: num -0.265
# $ 2.3: num -0.498
# $ 2.4: num [1:2] -1.602 -0.475
# $ 2.5: num [1:2] 2.005 -0.547
#ej6. 'split' en mas de un nivel pero con distinto numero de elementos
f10<-gl(2,5)
f20<-gl(5,3)
f30<-interaction(f10,f20) #ver los 5x2=10 niveles y distribucion en ellos
#1.1 1.1 1.1 1.2 1.2 2.2 2.3 2.3 2.3 2.4 1.4 1.4 1.5 1.5 1.5 #al no ser el numero de elementos de f10 y f11 iguales (longitud de objeto mayor no es múltiplo de la longitud de uno menor) rellena con lo que entra
#Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5
str(split(x,list(f10,f20))) #corta el vector en 10 niveles y reparte los elementos al estilo que vemos en 'interaction'. 'str' muestra la estructura interna del 'split'
rm(x,f,s,f1,f2,f3,f10,f11,f12)

#+------------------------------------------------------------------------------------------+
#| Debug (traceback, debug, browser, trace, recover)
#+------------------------------------------------------------------------------------------+
#traceback
mean(x) #x no esta definido y dara error
traceback() #ver donde dio el error, en este caso en la primera llamada
lm(y-x) #y no esta definido y dara error
traceback() #el error en este caso esta, 7 niveles de llamadas por debajo
#debug & browser
debug(lm) #el debugger saltara cuando se llame a lm()
lm(y-x) #aparece el codigo y el browser
#Browse[2]>n #ponemos n para avanza instruccion a instruccion y ver donde falla
#recover
options(error=recover) #permite usar recover durante la sesion (hemos agregado la opcion)
#cuando da el error nos permite mirar en cualquier parte del codigo













