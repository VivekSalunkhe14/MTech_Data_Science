#functions in R 

fun1 <- function(){
  print("Hello World")
}

fun1()

fun2 <- function(name){
  sprintf("Hi %s",name)
}

fun2()
fun2('Tom')
fun2(5)


fun3 <- function(fname,lname){
  sprintf("Hi %s %s",fname,lname)
}

fun3("Tom","Jerry")
fun3(lname="Tom",fname="Jerry")


fun4 <- function(x) x^2
fun4(5)


formals(fun4)
body(fun4)
environment(fun4)
attr(fun4,"srcref")



#inbuilt function
sum
.Primitive("sum")(1,2,3) #comes from c language
formals(sum)
body(sum)
environment(sum)
attr(sum,"srcref")


#list of functions
funs <- list(
  sqr = function(x) x^2,
  cube = function(x) x^3
)


funs$cube(3)
funs$sqr(2)


div <- function(x,y){
  x/y
}

div(4,2)
div(2,4)


#default value for y is 1
divdef <- function(x,y=1){
  x/y
}

divdef(5)
divdef(5,2)

#keep all default arguments must be at right and those that we need to pass must be kept at left to avoid below mistakes
dive <- function(x=1,y){
  x/y
}

dive(4,6)
dive(4)


mul <- function(x,y=x+1){
  x*y
  y
}

mul(2,4)


#post return code does not gets executed
mul <- function(x,y=x+1){
  return(x*y)
  y
}

mul(2,3)


mul <- function(x,y=x+1){
  return(x*y)
}

mul(2,4)
i <- mul(6)
i


#method for calling function
do.call(mul,args=list(x=2,y=4))

#gives 10 values having mean of 5 and std dev 1
?rnorm
rnorm(10,5,1)
d <- data.frame(a = rnorm(10,5,1),
                b = rnorm(10,5,1))

d
d[[1]]
mean(d[[1]])

#different functions to print same output
apply(d,1, function(x) if (x[1]<x[2]) x[1] else x[2])
pmin(d[[1]],d[[2]])
do.call(pmin,d)
?pmin

install.packages("microbenchmark")
library(microbenchmark)

#compares efficiency of different codes by giving their execution time,etc using microbenchmark library
microbenchmark(apply(d,1, function(x) if (x[1]<x[2]) x[1] else x[2]))
microbenchmark(pmin(d[[1]],d[[2]]))
microbenchmark(do.call(pmin,d))


#elipses when we dk exact # of arguments and it can be variable
f1 <- function(...){
  ..3
}


f1(1,2,5)


f2 <- function(...){
  for(i in list(...)){
    print(i)
  }
}

f2(1,2,3,4)
f2(9,12,23)


#sum function for variable # of arguments
f3 <- function(...){
  a = 0
  for(i in list(...)){
    a = a+i
  }
  a                                      #returning value of a
}

f3(1,2)
f3(1,2,3)
f3(1,2,3,4)
f3(1,2,3,4,5)


calc <- function(o,...){
  
  if (o=="+"){
    
    a=0
    
    for (i in list(...)) {
      
      a=a+i
      
    }
    
  }else if (o=="-"){
    
    a=0
    
    for(i in list(...)){
      
      a=a-i
      
    }
    
  }else if (o=="*"){
    
    a=1
    
    for(i in list(...)){
      
      a=a*i
      
    }
    
  }else{
    
    a=1
    
    for(i in list(...)){
      
      a=a/i
      
    }
    
  }
  
  a
  
}

calc("*",1,2,3)
microbenchmark(calc("*",1,2,3))


func <- function(...){
  
  ans = ..2
  
  switch(..1,
         
         '+' = for(i in list(...)[c(-1, -2)]) {ans=ans+i},
         
         '-' = for(i in list(...)[c(-1, -2)]) {ans=ans-i},
         
         '*' = for(i in list(...)[c(-1, -2)]) {ans=ans*i},
         
         '/' = for(i in list(...)[c(-1, -2)]) {ans=ans/i}
         
  )
  
  ans
  
}

func('+',5,7,8,1,2)
microbenchmark(func("*",1,2,3))



#global and local
x <- 10
g <- function(){
  x <- 20
  x
}


g()


#exclusively for R, if x is not found in function then it searches outside the function and if it finds x then it prints
x <- 10
g1 <- function(){
  y <- 20
  c(x,y)
}

g1()


#to check if variable exists in environment
exists("x")
exists("y")


#exists in function 
a <- 8
glo <- function(){
  if(!exists("a")){
    stop('value not there')
  }  
  else{
    a <- a+1
  }
  a
}

glo()



`%+%` <- function(a,b){
  a+b+b
}

2%+%3

`%+%` <- function(a,b){
  k=1
  for(i in seq(1:b)){
    k <- k*a
    a <- a-1
  }
  k
}

10%+%3
10%+%10


factorial <- function(x){
  if (x==0) return (1)
  else return (x * factorial(x-1))
}

factorial(3)
factorial(5)



fib <- function(n) {
  if ((n == 0) | (n == 1)) 
    return(1)
  else
    return(fib(n-1) + fib(n-2))
}

fib(5)


m1 <- matrix(c(1:10,11:20,21:30),10,3)
m1
 
apply(m1,1, sum)
apply(m1,2, sum)
apply(m1,1, function(x) sum(x)-mean(x))

fun1 <- function(x) sum(x)-mean(x)

#1:2 allows to work cell wise
apply(m1,1:2, sum)
apply(m1,1:2, function(x) x^2)



a <- (1:10)
b <- c(11:20)
c <- c(21:30)

#lapply works on list and returns a list
lapply(a,sum)
lapply(list(a),sum)       #returns output in form of list complicated
lapply(a, function(x) x^2)
lapply(list(a,b,c),sum)


#sapply simplifies the o/p by returning vector
sapply(a,sum)
sapply(list(a),sum)       #returns output in form of vector simplified
sapply(a, function(x) x^2)
sapply(list(a,b,c),sum)


#vapply gives vector in specified format
vapply(a,sum,numeric(1))
vapply(a,function(x) x%%2==0, logical(1))


#tapply table apply o/p in tabular format
data(iris)
tapply(iris$Sepal.Length,iris$Species,mean)
tapply(iris$Sepal.Length,iris$Species,function(x) c(mean(x),sum(x)))



#mapply to apply for multiple arguments 
mapply(function(x) x*x, iris$Sepal.Length)
mapply(function(x,y) x+y, iris$Sepal.Length,iris$Sepal.Width)