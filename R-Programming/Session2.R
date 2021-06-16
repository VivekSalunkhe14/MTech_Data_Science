install.packages("lobstr")

library(lobstr)

#2 obj pointing to same memory
a <- c(1,2,3,4)
b <- a

#a and b have same memory
obj_addr(a)
obj_addr(b)

#copy on modify
b[2] <- 9
#address of b is changed
obj_addr(b)

#trace the memory of a
a <- c(1,2,3,4)
tracemem(a)

b <- a
b[2] <- 9
#stop tracing a
untracemem(a)

#in list new allocation takes place for altered values only and not for the entire list
l1 <- list(1,2,3,4,5)
l2 <- l1
ref(l1,l2)

l2[2] <- 6
ref(l1,l2)

#in dataframe addressing is done on columns and hence when column is changed only particular address value is changed
#but when row manipulation is done all the address of columns value are changed
d1 <- data.frame(x=c(1,5,6),y=c(2,4,3))
d2 <- d1
ref(d1,d2)

d2[,2] <- d2[,2]+5
ref(d1,d2)


d3 <- d1
d3[1,] <- d3[1,]-3
ref(d1,d3)

d1
d2
d3


x <- c("z","z","xyz","a")
ref(x)
ref(x,character = T) # since z is repeated it maps both z to only one address

obj_size('a')

obj_size(1,2,3,4)

x <- c(1,2,3,4,5,6,7,8,9) #vector
obj_size(x) #size is 176B

y <- list(x,x,x) #list out of vector
obj_size(y) #size is 256B means increased by 256-176 = 80B

obj_size(list(NULL,NULL,NULL)) #size of blank list is 80B


#it stores start number, ending number and the increments hence for any large size vector size is 680B
obj_size(1:3)  #size is 680B
obj_size(1:30000) #size is 680B
obj_size(1:3000000) #size is 680B


#4 different equally distributed values between 10 and 20
seq(10,20,length.out = 4)

#concatenating and paste
cat("Hi","All") #cat concatenates and prints but nevers save
paste("Hi","All") #prints and saves it in a variable


{
cat('Hello','World')  
cat('How','are','you')  
}

{
  paste('Hello','World')  
  paste('How','are','you')  
}


{
  cat('Hello','World \n')  
  cat('How','are','you')  
}

a <- cat('Hello','World')
a

a <- paste('Hello','World')
a

cat('Hello \n','World') #takes \n as new line
paste('Hello \n','World') #takes \n as a part of Hello World and prints it 

a <- c(1,2,3,4,5,6)

# first coercion takes place then in operator condition is checked
3 %in% a #3 is in a hence TRUE
3.0 %in% a
'3' %in% a # 3 is converted to string 3 and hence returned true
'3.0' %in% a # 3 is converted to string 3 and not 3.0 hence false

#if(T){
 # print("will execute")
#}

#if statement
x <- 5
if(x %in% a){
  print(paste(x,"there in list"))
}


if(x%%2 == 0){
  print('EVEN')
}else{
  print('ODD')
}

x=6
if(x>0){
  print(paste(x,'is +ve'))
}else if (x<0){
  print(paste(x,'is -ve'))
}else{
  print(paste(x,'is zero'))
}


x <-  as.numeric(readline("Enter no -"))
if(x>0){
  print(paste(x,'is +ve'))
}else if (x<0){
  print(paste(x,'is -ve'))
}else{
  print(paste(x,'is zero'))
}


x <-  as.numeric(readline("Enter Score -"))
if(x>80){
  print(paste(x,'is Grade A'))
}else if (x>60 & x<=80){
  print(paste(x,'is Grade B'))
}else if (x>40 & x<=60){
  print(paste(x,'is Grade C'))
}else{
  print(paste(x,'is Grade F'))
}

#one liner codes for if else for small code
if(x%%2 == 0) 'Even' else 'Odd'

ifelse(x%%2==0,'Even','Odd') #more preferred

x = 5
ifelse(x>0,'+ve',ifelse(x<0,'-ve','zero'))



#for loop
for(i in 1:3){
  print(i)
}


x <- c(2,5,3,9,8,11,6)
for(num in x){
  print(num)
}


#count no of even numbers
count <- 0
for(val in x){
  if(val %% 2 == 0){
    count = count+1
  }
}
print(count)

#while loop
x <- 0
while(x<20){
  print(x)
  x <- x+1
}

#break in while
x <- 0
while(T){
  print(x)
  x <- x+1
  if(x==10) break
}

#next in while
x <- 10
while(x){
  x <- x-1
  if(x%%2==0)
    next
  print(x)
}

#repeat is same as while(T) i.e. infinite
x <- 10
repeat{
  print(x)
}

#order : functions -> for -> while -> repeat : bcoz loops will slow down execution hence use loops as less as possible 
# try executing code with functions

#system.time -> run time taken by code to execute
system.time(mean(1:1000000))
#if there are 2 functions we can use system.time to compare efficiency of the codes


#switch
x <- 4 
cond <- switch(x,
               print('You select 1'),
               print('You select 2'),
               print('You select 3'),
               print('You select 4'),
               )

x <- 'App'
cond <- switch(x,
               'App'='Apple',
               'Nok'='Nokia',
               'Sam'='Samsung',
               'Others'
)

a <- list()
process <- readline("1: Add, 2: Remove")
if(process==1){
  name <- readline('Enter Name ')
  id <- as.integer(readline('Enter ID'))
}else{
  id <- as.integer(readline('Enter ID'))
}

switch(process,
       "1" = a[id] <- name,
       "2" = a[id <- NULL]
       )


x <-  as.numeric(readline("Enter No1 -"))
y <-  as.numeric(readline("Enter No2 -"))
process <- readline("1: Add, 2: Subtract, 3: Multiply,4: Divide")
output <- switch(process,
       "1" = x+y,
       "2" = x-y,
       "3" = x*y,
       "4" = x/y
       )


x <- as.numeric(readline("Enter Number 1:"))

y <- as.numeric(readline("Enter Number 2:"))

operation = readline("Enter operation:")



switch(operation,
       
       '+' = print(x+y),
       
       '-' = print(x-y),
       
       'x' = print(x*y),
       
       '/' = print(x/y)
       
)

#checking user input with sample 
for(i in 1:3)
  {x <- as.numeric(readline("Enter Number: "))
   y = sample(10,1)
   if(x == y){
     print(y)
     print('Bingo')
   }
  else if (x < y){
    print(y)
    print(paste(x,'less than sample'))
  }
  else{
    print(y)
    print(paste(x,'greater than sample'))
  }
}


#login system
attempt <- 3
password <- 'pass'
while(attempt!=0){
  check <- readline(prompt = "Enter your password")
  if(check==password){
    print("You are logged in/Login Successful")
    break
  }else{
    attempt <- attempt-1
    print(paste("Incorrect Password,You have",attempt,"attemptsleft"))
  }
}


#dataframes
mtcars
mtcars[mtcars$cyl %in% 4,]

'%ni%' = Negate('%in%')
mtcars[mtcars$cyl %ni% 4,]


mtcars[,colnames(mtcars)%in%c('mpg','disp')]
mtcars[,colnames(mtcars)%ni%c('mpg','disp')]
subset(mtcars,select = -c(mpg,disp))

#print with string formatting
sprintf("Hello %s","James")
sprintf("Hello %s today is %s","James","Saturday")
name <- 'James'
sprintf("%s is %.1f feet tall",name,6.1)
sprintf("%s is %.2f feet tall",name,6.1)
sprintf("%s is %.3f feet tall",name,6.1)
sprintf("%s is %10.1f feet tall",name,6.1)
sprintf("%s is %.1+f feet tall",name,6.1) #requirement of sign in output can be satisfied using this
sprintf("%s is %d feet tall",name,6)
sprintf("%s is %d feet tall",name,6.1)
sprintf("%s is %e feet tall",name,6.1)


for (i in iris$Sepal.Length){
  print(sprintf("%.1f length",1))
}


x <- as.numeric(readline("Enter Year: "))
if(x%%4==0){
  if(x%%100==0 && x%%400==0){
    print("Leap Year")
  }
  else{
    print("Not a Leap Year")
  }
}else{
  print("Not a Leap Year")
}

