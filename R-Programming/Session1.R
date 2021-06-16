1+2

2+3

"+"(5,5)

a <- 10 #(Alt+"-")
print(a)

rm(list=ls()) #clears all the variables,values in order to create a fresh program

median(a = 1:10) #median tries to execute itself first then assignment happens hence error
median(a <-  1:10) #assignment first then median is calculated

x <- y <- 5 #multiple variables with same values

num <- c(1,2,4) #assigns the value
num #seperate print statement
typeof(num) #double or float

(num1 <- c(1,2,3)) #assigns and print at the same time
numi <- c(1L,2L,3L)
typeof(numi) #integer

seq(1:10) #cannot use steps with : operator
seq(1,100,2) #can use steps with , operator
?seq #documentation for any command

rep(1,4) #repeating 1 for 4 times
rep(c(1,2,3),4) #repeating multiple values 1,2,3 for 4 times
rep(1:3,each=2) #each function

l <- c(TRUE,FALSE,T,F) #boolean
l

l <- c(T,F,5) #coercion everything is converted to numeric
l

#order of coercion : character, complex, numeric, integer, logical and raw
chr <- c("Hi","Hello")
class(chr) #similar to typeof

x <- unclass(chr) # removes the class function if character removes character class 
x
class(x)

com <- c(4+3i) #complex
typeof(com)

n <- "5" #5 in character format
as.integer(n) #converts into integer 


as.raw(16)

charToRaw("A")

#can use NA as int,char etc
data <- c(NA)
data

data <- c(NA,2)
data

data <- c(NA_integer_,2L)
data

data <- c(NA_character_,2)
data

num <- 5
is.integer(num) #5 is not int

is.double(num) # 5 is double

x <- c(20,10,40,50,30,NA,0)
names(x) <- c('A','B','C','D','E','F','G')
x

x[1]
x[-2]
x[-c(1,4)]
x[-1:-3] #remove the 1st 3 values remaining will be printed
x[2:4]
x[c(T,T,F,F,T,T,F)]
x[c(T,F)]

s = c(1:10)
sum(s)
mean(s)
median(s)
mode(s)

x[x>30] #gives subset including NA
subset(x,x>30) #gives a subset and skips NA
?subset

mean(x) #since NA is present output is NA
?mean
mean(x,na.rm = TRUE) #NA is removed from x and mean is calculated

which(x>30) #positions where x > 30

x[which(x>30)] #similar to which

any(x>20) # gives a boolean result if condition is true: or logic

any(x>30)

all(x>30) # gives a boolean result if condition is true: and logic

length(x) #total values in x

x[-length(x)] #exclude the length of x that is last value and print result

x[1:length(x)-1] #exclude the length of x that is last value and print result

x[3:length(x)-1]

x

order(x) #orders in ascending and gives position: default for NA is last

order(x,decreasing=TRUE) #orders in descending and gives position: default for NA is last

x[order(x)]

x[order(x,decreasing=TRUE)]

x[order(x, na.last = F)] #prints x in ascending with NA at start

sample(x) #can be used for modelling and each time it gives diff values

x[c(1,2,2)]

x[c(1,2,2.5)] #values after decimals are truncated 

x[c(1,2,2.5,2.8)]

x[c('B','E')] #print values according to the names

x['H'] <- 60 #add a new element 60 with label H 
x
?append

x <- c(x[1:4],I=70,x[5:8]) #added 70 in between of the vector
x

z <- vector(length = 5)
z
?vector
vector() #no length givens hence 0 is printed
vector(length=1) # false with length of 1

vector(length=5,mode="numeric") #false is converted to 0 numeric

z <- vector(mode='numeric',length = 5)
z <- vector(mode='integer',length = 5)

vector('numeric',4)

a <- c(1,2,4) + c(6,0,9) # add 2 vectors
a 

a <- c(1,2,4) / c(6,0,9) # divide 2 vectors
a

a <- c(1) + c(6,0,9,10,13) # add 1 to every value in 2nd vector: cyclic property
a

a <- c(1,2,4) + c(6,0,9,10,13)#warning since length of both vector is not compatible i.e 5 is not multiple of 3
a

#list/recursive vectors: list is combination of vectors

x <- list(1:4,"abc",T,c(1.3,4.9))
x
str(x) 

typeof(x)
x[1] #prints 1 to 4

x[4]
typeof(x[1]) #gives type list rather than integer because it retains characteristics of parent function list 
typeof(x[2])

x[[1]] #only content is displayed excluding list part [[1]]
typeof(x[[1]]) #excludes the type of parent list and displays type of content in it i.e Integer or gives most simplified value

is.recursive(x)#true bcoz it can have multiple list in it
x <- list(list(list(list())))
x

x <- list(list(1,20),c(3,4))#combining lists
x

y <- c(list(1,2),c(3,4))#creating seperate lists
y

x[[1]][[2]]
x[[2]][[1]]
x[[2]][[2]]

y[[4]]

unlist(x) #gives atomic vector out of list
x
typeof(unlist(x))

3-2 == 4-3 # boolean output after comparing LHS and RHS

3-2 != 4-3 #!= not equal to operator

(1==1)&(2==1) # TRUE & FALSE -> FALSE

(1==1)|(2==1) # TRUE | FALSE -> TRUE

1 == "1" #coercion happens and then comparison hence true output
#f the two arguments are atomic vectors of different types, one is coerced to the 
#type of the other, the (decreasing) order of precedence being character, 
#complex, numeric, integer, logical and raw.

?`==`

-1 < FALSE #false is taken as 0 and since -1 < 0 means true

identical(1,'1') #coercion does not happen and 1 is compared to character 1 hence false
identical(1,1)
identical(2,4/2)


y <- 1:10
attr(y,"my_attribute") <- "This is a vector"
y
attributes(y)
names(y) = c('a','b','c','d','e','f','g','h','i','j')

unname(y)
y <- unname(y)
y

#factor is memory efficient by using labels and also goods for fixed and repetitive values
x <- factor(c("a","b","b","a"))#can be used for month names, weekdays or in general for data that wont change
class(x)
x
levels(x)

x <- factor(c("a","b","b","a","b","b","a"))
x
levels(x)#levels is used to map a and b to numeric value like 0 and 1 and stores it numerically in memory thus making it efficient

x[8] <- 'b'
x

x[9] <- 'c'#no level assigned to c hence warning message given and it gives level NA
x

gender <- c("m","m","m")
gender <- factor(gender, levels = c("m","f"))#we manually assign levels in factor function

gender
gender[4] <- 'f'
gender

#attributes of factors are levels, class as factors
#matrices 

a <- matrix(1:6,ncol=3,nrow=2)
a

?array
#create 2 matrices of 2*3
b <- array(1:12,c(2,3,2))#1st 2 is rows, 3 is no of cols, last 2 is create 2 diff matrices
b

#alternate way to create 2 matrices of 2*3
c <- 1:12
c
dim(c) <- c(2,3,2)
c  

dim(b)
length(b)
nrow(b)
ncol(b)

rownames(b) <- c('A','B')
b

colnames(b) <- c('a','b','c')
b

dimnames(b) <- list(c('A','B'),c('a','b','c'),c('M1','M2'))
b

a
t(a)

a <- rbind(a,c(7,8,9))
a
c <- cbind(a,c('a','b','c'))
c

c[1,2]
c[1,]
c[,1]

#dataframe: multiple types can be present unlike matrices
#similar to list
df <- data.frame(x = 1:3,y = c("a","b","c"),stringsAsFactors = FALSE)#no factors will be created by default
df
str(df) #structure of dataframe

is.data.frame(df)

df <- cbind(df,data.frame(z = 3:1))
df

df <- rbind(df,data.frame(x="a",y="z",z=10))
df

df$x
df[,1]
df[c(T,T,F,T),1]
df[c(T,T,F,T),c(T,F,T)]
df$x>2
df[df$x>2,]
df[df$x>2,2]
df[c("x","z")]
df[,c("x","z")]

df["x"] #output is structured & contained bcoz type is list
df[,"x"] #output is unstructured & not contained bcoz type is double

typeof(df["x"]) #list
typeof(df[,"x"]) #double

str(df["x"])# structure of x in dataframe

df

?setdiff
setdiff(c("x","y","z"),"z")
setdiff(names(df),"x")
df[setdiff(names(df),"x")]

df$z <- NULL
df

df <- data.frame(x = 1:3)
df
df$y <- list(1:2,1:3,1:4)
df

#all the datasets available inbuilt in r
data()

mtcars
data("iris") #adds it as promise which means that data is present but do u want to load the data now

mtcars
View(mtcars)
rownames(mtcars)

mtcars[mtcars$cyl==4,]
df <- mtcars[-1:-4,]
df <- mtcars[(mtcars$cyl == 4) | (mtcars$cyl == 6),]


names(mtcars)
include <- 'cyl'
mtcars[[include]] #include is variable hence it checks if variable is created and if it is it prints value of the variable
mtcars$include #include is considered string and since it is not found in data hence null is printed


mtcars$di #col name is unknown but we know it starts with di hence it searches in data and prints column disp 
#it prints matching values to the string after $ 
mtcars[[di]] #here exact match is required for the value inside brackets else we get error


x <- 1:5
x
x[-1] <- 4:1
x

x[c(1,4)] <- 2:3
x

x[c(1,1)] <- 2:3# first value at 1st posi is replaced with 2 then again value at 1st posi is replaced with 3
x

x[x<3] <- 0
x


x <- c("m","f","u","f","f","m","m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup

lookup[x]
unname(lookup[x])
c(m = "Male", f = "Female", u = NA)[x]

grades <- c(1,2,2,3,1,2,3,1)
info <- data.frame(
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F,F,T)
)

grades
info

id <- match(grades,info$grade) #search for values in grades in the dataframe info and returns the position value 
id

info[id,]

(x1 <- 1:10 %% 2 == 0) #gives true and false for even and odd posi
x1

(x2 <- which(x1 <- 1:10 %% 2 == 0))

paste("Hello", "World") #combine strings
paste("Hello", "World","!!")
paste("Hello", "World", sep='-') #combine strings using - seperator

myname <- readline(prompt="Enter Name: ")
myage <- readline(prompt="Enter Age: ")
myage <- as.integer(myage)

myage <- as.integer(readline(prompt="Enter Age: "))
print(paste("Hi, my name is", myname, "and I am", myage, "years old."))
