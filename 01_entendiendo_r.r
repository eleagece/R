#==================#
# 1. Entendiendo R #
#==================#

#+------------------------------------------------------------------------------------------+
#| BASICOS
#+------------------------------------------------------------------------------------------+
#####################################################################
# Basicos, vectores y asignaciones
#####################################################################
source(subtest.r) #ejecutar ordenes desde script 'subtest.r' en disco
sink("C:/LA/OM/R/record.lis") #redirige la salida a archivo (hasta ahora se iba a consola)
sink() #redirige la salida a salida estandar (hasta ahora se iba al archivo 'record.lis')
x<-c(1,3,5,7) #crea un vector de 4 numeros (tipo de datos mas simple)
y<-c(2,4,6,8) #crea un vector de 4 numeros (tipo de datos mas simple)
z=c(1,2,3,4) #asignar funciona tambien con '=' en la mayoria de los casos
w=c(x,10,y,20,z) #asignar usando objetos pasados
x #muestra los datos de 'x'
objects() #objetos que existen ahora mismo
rm(x,y,z,w) #elimina los objetos que creamos antes 
ls() #mismo que 'objects()'
help(ls) #ayuda sobre el comando 'ls'

#####################################################################
# Operaciones aritmeticas
#####################################################################
x<-c(2,4,6,8)
y<-c(1,1,1,1)
z<-x*2+y #utiliza los objetos 'x' e 'y' elemento a elemento
z #muestra los datos de 'z'
#mas operaciones aritmeticas: log, exp, sin, cos, tan, sqrt...
range(x) #muestra el minimo y el maximo del vector
c(min(x),max(x)) #lo mismo que antes
sum(x) #sumatorio de x
length(x) #longitud de x
sum(x)/length(x) #media de x
mean(x) #media de x tambien
sum((x-mean(x))^2)/(length(x)-1) #varianza de x
var(x) #varianza de x tambien
sort(x) #ordena el vector de menor a mayor
rm(x,y,z)

#+------------------------------------------------------------------------------------------+
#| TIPOS DE DATOS
#+------------------------------------------------------------------------------------------+
#####################################################################
# Generar vectores (:, seq, rep)
#####################################################################
x<-1:30
y<-30:1
z<-seq(length=51,from=-5,by=.2) #51 elementos empezando en -5 en incrementos de 0.2
t<-seq(-5,5,.2) #empezando en -5 y acabando en 5 en incrementos de 0.2
v<-rep(c(1,2,3,4),times=5)
rm(x,y,z,t,v)

#####################################################################
# Listas
#####################################################################
#TO DO

#####################################################################
# Vectores logicos (<, <=, >, >=, ==, !=, &, |, !)
#####################################################################
x<-c(2,4,6,8,10)
y<-x>5 #genera un vector de valores logicos a partir de condiciones
#mas operaciones logicas: <, <=, >, >=, ==, !=
#operadores logicos: &, |, !
z<-x>8|x<4
rm(x,y,z)

#####################################################################
# Vectores de caracteres
#####################################################################
pegado1<-paste(c("X","Y"), 1:10, sep="") #pega de forma evidente, y lo que pega lo hace sin espacio
pegado2<-paste(c("X","Y"), 1:10) #pega de forma evidente y lo que pega lo hace con espacio
rm(pegado1,pegado2)

#####################################################################
# Matrices
#####################################################################
m1<-matrix(1:6,nrow=2,ncol=3) #Crea una matriz y la rellena por columnas
m2<-matrix(1:3,nrow=2,ncol=3) #Crea una matriz y la rellena por columnas repitiendo datos
m<-1:10 #Crea un vector de 10 elementos
dim(m)<-c(2,5) #transformar el vector en una matriz de 2x5 elementos
x<-1:3
y<-10:12
cbind(x,y) #asocia los vectores a columnas (columns)
rbind(x,y) #asocia los vectores a filas (rows)
rm(m1,m2,m,x

#####################################################################
# Factores
#####################################################################
x<-factor(c("y","y","n","y","n")) #factor con dos niveles ('y' y 'n')
x #ver el factor, los niveles y segun el orden en que aparezcan cual es el nivel mas prioritario
x<-factor(c("y","y","n","y","n"),levels=c("y","n")) #crear el factor diciendo el orden de los niveles
x #ver que cambia
table(x) #ver el numero de elementos que hay de cada nivel
unclass(x) #muestra la representacion real de los factores (numerico)

#####################################################################
# Valores perdidos
#####################################################################
z<-c(1:3,NA,0/0) #los valores NA indican Not Available. 0/0 es NaN
isNA<-is.na(z) #te dice cuales son NA o NaN
isNaN<-is.nan(z) #te dice cuales son NaN
rm(z,isNA,isNaN)

#####################################################################
# Data frames
##################################################################### 
#todas las columnas tienen el mismo tamano
#los elementos de cada columna pueden ser de distinto tipo (en las matrices no)
#las filas pueden tener nombres 'row.names'
#se crean con 'read.table()' y 'read.csv()'
#se puede crear una matriz desde un data frame con 'data.matrix()'
x<-data.frame(foo=1:4,bar=c(T,T,F,F)) #crea un data.frame con dos columnas ('foo' y 'bar')
nrow(x) #numero de filas del data.frame
ncol(x) #numero de columnas del data.frame
rm(x)

#####################################################################
# Dando nombres
##################################################################### 
#en vectores
x<-1:3
x #ver los valores de x
names(x) #ver los nombres de x. No hay
names(x)<-c("foo","bar","norf") #poner nombres a cada elemento
x #ver los valores de xcon los nombres
names(x) #ver los nombres de x
#en listas
y<-list(a=1,b=2,c=3)
y
#en matrices
m<-matrix(1:4,nrow=2,ncol=2)
dimnames(m)<-list(c("a","b"),c("c","d")) #filas con etiqueta 'a' y 'b'. columnas con etiquieta 'c' y 'd'
m
rm(x,y,m)

#+------------------------------------------------------------------------------------------+
#| LECTURA Y ESCRITURA
#+------------------------------------------------------------------------------------------+
#####################################################################
# read.table, read.csv
##################################################################### 
# argumentos:
# -file - nombre o conexion del archivo
# -header - indica si el archivo tiene cabecera
# -sep - el tipo de separador
# -colClasses - vector que indica la clase de cada columna
# -nrows - numero de filas
# -comment.char - el caracter que se usa para comentar
# -skip - las lineas que se van a ignorar desde el principio
# -stringsAsFactors - si quieres leer 
data<-read.table("foo.txt") #no hace falta especificar argumentos si la tabla esta "limpia" y el separador es espacio
data<-read.csv("foocsv.txt") #igual que 'read.table' pero el separador es una coma
rm(data)

#####################################################################
# dput, dget, dump, source
##################################################################### 
#dput, dget
y<-data.frame(a=1,b="a")
y
dput(y) #crea codigo en R que permite reconstruir la variable y
dput(y,file="y.R") #ademas de crear el codigo en R lo guarda en un archivo
yNew<-dget("y.R") #recupera 'y' del archivo
yNew
rm(y,yNew)
#dump, source
x<-"foo"
y<-data.frame(a=1,b="a")
dump(c("x","y"),file="data.R") #guardamos variables 'x' e 'y' en 'data.R'
rm(x,y) #las eliminamos de los objetos activos
source("data.R") #las recargamos desde data.R
x #vemos que 'x' esta recuperada
y #vemos que 'y' esta recuperada
rm(x,y)

#+------------------------------------------------------------------------------------------+
#| CONEXIONES CON ARCHIVOS, ARCHIVOS COMPRIMIDOS Y PAGINAS WEB
#+------------------------------------------------------------------------------------------+
#####################################################################
# file, gzfile, bzfile, url
#####################################################################
x<-list(1,"a",TRUE,1+4i)

#+------------------------------------------------------------------------------------------+
#| SUBSETTING ([], [[]], $)
#+------------------------------------------------------------------------------------------+
#####################################################################
# Subsetting en vectores y listas
#####################################################################
x<-c("a","b","c","c","d","a") #vector de elementos
y<-list(foo=1:4,bar=0.6) #lista de dos elementos de tipo distinto
z<-list(a=list(10,12,14),b=c(3.14,2.81))
# uso de [] (acceso como subconjunto en vectores y listas)
x[1] #[] devuelve subconjunto de x (sigue siendo un vector, de un elemento)
x[2] #lo mismo que antes
x[1:4] #lo mismo que antes
x[x>"a"] #lo mismo que antes pero usando indice logico. te devuelve segun se cumpla o no la condicion en cada elemento
u<-x>"a"
u
x[u] #lo mismo que antes pero teniendo guardada la condicion
y[1] #obtiene una sublista de un elemento
typeof(y[1]) #nos dice que 'y[1]' es de tipo 'list'
y["foo"] #obtiene sublista buscando por nombre
y[c(1,3)] #obtiene sublista de elementos salteados (el 1 y el 3)
# uso de [[]] (acceso como elemento independiente de la lista, no subconjunto)
# usar [[]] en vectores es igual que usar [] ya que los subconjuntos son elementos del mismo tipo 
y[[1]] #obtiene un elemento de tipo entero
typeof(y[[1]]) #nos dice que 'y[[1]]' es de tipo 'integer'
y$foo #obtiene elemento independiente de la lista
y[["foo"]] #obtiene elemento independiente de la lista (hace lo mismo)
typeof(y$foo) #nos dice que 'y$foo' es de tipo 'integer'
typeof(y[["foo"]]) #nos dice que 'y[["foo"]]' es de tipo 'integer'
x$f #obtiene "foo" igualmente, ya que hace busquedas parciales
x[["a",exact=FALSE]] #igual que lo anterior, busqueda parcial
name<-"foo"
y[[name]] #es valido, pero 'y$name' no
z[[c(1,3]] #obtiene el tercer elemento de la primera lista
z[[[1]][[3]]] #tambien obtiene el tercer elemento de la primera lista
z[[c(2,1)]] #obtiene primer elemento de la segunda lista
z[[[2]][[1]]] #tambien obtiene primer elemento de la segunda lista
rm(x,y,z,name)

#####################################################################
# Subsetting en matrices
#####################################################################
x<-matrix(1:6,2,3) #matriz con los elementos 1 a 6 repartidos en 2 filas y 3 columnasx
x[1,2] #elemento de fila 1 columna 2
x[2,1] #elemento de fila 2 columna 1
x[1,] #elementos de la fila 1
x[,2] #elementos de la columna 2
x[1:2,1:2] #elementos de las filas 1 y 2 y las columnas 1 y 2 (forzosamente es formato matriz)
# hemos dicho que [] da subconjuntos. pero en los casos anteriores no se devuelven submatrices
x[1,2,drop=FALSE] #elemento de fila 1 columna 2 en formato matriz
x[2,1,drop=FALSE] #elemento de fila 2 columna 1 en formato matriz
x[1,,drop=FALSE] #elementos de la fila 1 en formato matriz
x[,2,drop=FALSE] #elementos de la columna 2 en formato matriz
x[1:2,1:2,drop=FALSE] #elementos de las filas 1 y 2 y las columnas 1 y 2 (aunque lo digamos explicitamente forzosamente ya era de formato matriz)
rm(x)

#####################################################################
# Tratando con elementos NA mediante subsetting
#####################################################################
x<-c(1,2,NA,4,NA,5)
y<-c("a","b",NA,"d","f",NA)
#NAs sobre un vector
bad<-is.na(x) #FALSE,FALSE,TRUE,FALSE,TRUE,FALSE
x[!bad] #usando indice logico cogemos los que no son NA (!TRUE)
good<-complete.cases(x) #TRUE,TRUE,FALSE,TRUE,FALSE,TRUE
x[good] #usando indice logico cogemos los que son buenos(TRUE)
#NAs sobre dos vectores a la vez
good2<-complete.cases(x,y) #TRUE,TRUE,FALSE,TRUE,FALSE,FALSE con un NA ya da false
x[good2] #5 ya no se muestra
y[good2] #f ya no se muestra
#NAs sobre data frames
rm(x,y,good,good2,good3)

#####################################################################
# Subsetting en data frames con los conceptos anteriores
#####################################################################
airquality[1:6,] #elementos de las 6 primeras filas del data frame
#  Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6
good<-complete.cases(airquality) #nos dice que filas estan completas
filtered<-airquality[good,] #filtramos por filas completas
filtered[1:6,] #elementos de las 6 primeras filas del frame filtrado
#  Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#7    23     299  8.6   65     5   7
#8    19      99 13.8   59     5   8
airquality[good,][1:6] #lo mismo que antes pero solo en un paso
rm(good,filtered)

#####################################################################
# Operaciones vectorizadas
#####################################################################
#sobre vectores
v1<-1:4
v2<-6:9
v1+v2 #suma elemento a elemento
v1>=2 #filtrado elemento a elemento
#sobre matrices
m1<-matrix(1:4,2,2)
m2<-matrix(rep(10,4),2,2)
m1*m2 #multiplica elemento a elemento
m1/m2 #divide elemento a elemento
m1%*%m2 #verdadera multiplicacion de matrices
rm(v1,v2,m1,m2)