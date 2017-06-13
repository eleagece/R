#======================#
# 2. Programando con R #
#======================#

#+------------------------------------------------------------------------------------------+
#| Estructuras de control
#+------------------------------------------------------------------------------------------+
#####################################################################
# if-else
#####################################################################
#tipico 'if-else'
if (x>3) #x solo debe tener un elemento o este if falla
	{
	y<-10
	}
else
	{
	y<-0
	}
#otra forma de hacerlo en R
y<-if (x>3)
	{
	10
	}
else
	{
	0
	}
rm(x,y)

#####################################################################
# bucles for
#####################################################################
#tipico 'for'
for (i in 1:10)
	{
	print(i)
	}
#'for' sobre un vector
x<-c("a","b","c","d")
for (i in 1:4)
	{
	print(x[i])
	}
for (i in seq_along(x)) #'seq_along' saca los indices del vector
	{
	print(x[i])
	}
for (letter in x) #el 'for' puede ir sobre letras del vector
	{
	print(letter)
	}
for (i in 1:4) #una sola instruccion en el cuerpo permite omitir {}
	print(x[i])
#'for' sobre una matriz
m<-matrix(1:6,2,3)
for (i in seq_len(nrow(m))) #'seq_len()' saca una secuencia de la longitud pasada
	{
	for (j in seq_len(ncol(m)))
		{
		print(m[i,j])
		}
	}
rm(x,m)
	
#####################################################################
# bucles while
#####################################################################
#tipico 'while'
count<-0
while(count<10)
	{
	print(count)
	count<-count+1
	}
#tipico 'while'
z<-5
while(z>=3 && z<=10)
	{
	print(z)
	coin<-rbinom(1,1,0.5) #probabilidad 0.5 de que salga un 1 en 1 intento
	if (coin==1)
		z<-z+1
	else
		z<-z-1
	}
rm(coin,z)

#####################################################################
# repeat, next
#####################################################################
#repeat
repeat
	{
	#nunca para a no ser que hagas un break aqui
	}	
#next
for (i in 1:100)
	{
	if (i<=20)
		next #pasa de las 20 primeras iteraciones
	print[i]
	}
	
#+------------------------------------------------------------------------------------------+
#| Funciones
#+------------------------------------------------------------------------------------------+
#####################################################################
# funciones de ejemplo simples
#####################################################################
add2<-function(x,y)
	{
	x+y
	}
above10<-function(v)
	{
	usedV <- v>10
	x[usedV]
	}
above<-function(v,n)
	{
	usedV<-v>n
	v[usedV]n 
	}
above <- function(v,n=10) #10 es valor por defecto
	{
	usedV<-v>n
	v[usedV]
	}
columnmean <- function(y, removeNA=TRUE) #'y' es un data.frame o matrix
	#calcula la media de cada columna
	{
	nc<-ncol(y)
	means<-numeric(nc)
	#la linea anterior se podria hacer asi tambien:
	#means<-1:ncol(y)
	#for (i in seq_along(means))
	#	means[i]=0
	for(i in 1:nc)
		means[i]<-mean(y[,i],na.rm=removeNA) #la media de cada columna 'i' se guarda en 'means[i]'
	means #lo mostramos
	}
	
#####################################################################
# valores por defecto y matching al llamar a las funciones
#####################################################################
args(lm) #muestra los argumentos de la funcion 'lm' y sus valores por defecto
#function (formula, data, subset, weights, na.action, method = "qr", 
#    model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
#    contrasts = NULL, offset, ...) 
#en la llamada a 'lm'
#-no es necesario especificar los que tienen valor por defecto
#-se puede hacer matching parcial
#-se pueden poner los argumentos en distinto orden al definido si se deducen bien (no recomendable)
#-orden de los matches: primero busca por nombre iguales, segundo por nombre parciales, y tercero por posicion
lm(data=mydata,y-x,model=FALSE,1:100) #matching por nombre y segun el orden
lm(y-x,mydata,1:100,model=FALSE) #matching solo por el orden

#####################################################################
# evaluacion perezosa, ...
#####################################################################
#evaluacion perezosa
f1 <- function(a,b)
	{
	a^2
	}
f1(2) # la evaluacion perezosa funciona bien aunque no especifiques b. ademas no hay error porque el return es la ultima instruccion del cuerpo
f2 <- function(a,b)
	{
	print(a)
	print(b)
	}
f2(45) #la evaluacion perezosa imprime 'a' y da error en 'b' porque b no esta definido
#... para extender otra funcion y no repetir todos los argumentos
myplot <- function(x,y,type="1",...)
	{
	plot(x,y,type=type,...)
	}
#... cuando no se sabe el numero de argumentos de la funcion a priori
args(paste) #junta un numero indeterminado de argumentos
#function (..., sep = " ", collapse = NULL) 
args(cat) #junta e imprime un numero indeterminado de argumentos
#function (..., file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE)
paste("a","b",sep=":") #separa elementos por ':'
paste("a","b",se=":") #no funciona partial match por los '...' y toma 'se' como un elemento mas de los que hay en '...'
rm(f1,f2)

#####################################################################
# scoping
#####################################################################
make.power <- function(n)
	{
	pow <- function(x)
		{
		x^n
		}
	pow
	}
cube<-make.power(3)
square<-make.power(2)
cube(3)
square(2)
ls(environment(cube)) #te dice que la funcion tiene dentro 'n' y 'pow'
get("n",environment(cube)) #te dice que 'n' vale 3
ls(environment(sqare))
get("n",environment(sqare))
#en R existe el 'lexical scoping'. El valor de 'y' se busca donde se ha definido
#y no desde donde se ha llamado a la funcion que tiene 'y'. Por tanto
#g(x) usa y<-10 y no y<-2 (en ese caso seria 'dynamic scoping')
y<-10
f<-function(x)
	{
	y<-2
	y^2+g(x)
	}
g<-function(x)
	{
	x*y
	}
#un problema del lexical scoping es qeu todos los objetos tienen que estar
#guardados en memoria

#+------------------------------------------------------------------------------------------+
#| Hora y fecha - https://www.coursera.org/learn/r-programming/lecture/yl7BO/dates-and-times
#+------------------------------------------------------------------------------------------+
#TO DO
#fecha y hora tienen clases especiales en R para tratar con ellas numerica y estadisticamente.
#para fechas usan 'Date' y para horas usan 'POSIXct' y 'POSIXlt'.
#si tenemos horas y fechas en formatos no propios de R podemos parsearlos usando 'strptime' o 'as.Date',
#'as.POSIXct' y 'as.POSIXlt'


