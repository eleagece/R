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
rm(m1,m2,m,x,y)

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
#TO DO

#+------------------------------------------------------------------------------------------+
#| SUBSETTING
#+------------------------------------------------------------------------------------------+
x<-c("a","b","c","c","d","a")
x[1]
x[2]
x[1:4]
x[x>"a"]
u<-x>"a"
u
x[u]
https://www.coursera.org/learn/r-programming/lecture/hVKHm/subsetting-lists 4:30

#####################################################################
# XLConnect (sacar datos de archivos excel)
#####################################################################






#####################################################################
# XLConnect (sacar datos de archivos excel)
#####################################################################
# install.packages("XLConnect") #Activar en caso de que no tengas XLConnect instalado
library(XLConnect) #Para poder importar datos de excel
excelRef <- loadWorkbook("C:/LA/OM/R/xls2.xls")
tabla <- readWorksheet(excel, sheet = "nombreDeLaHoja", header = TRUE)
sink("C:/LA/OM/R/record.lis") #redirige la salida a archivo
sink() #redirige la salida a salida estandar (consola)