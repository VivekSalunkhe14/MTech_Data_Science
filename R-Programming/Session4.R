iris<-read.csv("C:/Users/vivek/Desktop/iris.csv")
str(iris)


versicolor <- iris[iris$Species=="Iris-versicolor",]
versicolor

diff = versicolor$SepalLengthCm - versicolor$SepalWidthCm
versicolor = cbind(versicolor,diff)

colMeans(Filter(is.numeric,versicolor),na.rm = TRUE)
summary(versicolor)

#data("iris")


data("ChickWeight")
str(ChickWeight)


unique(ChickWeight$Diet)
apply(ChickWeight,2, sum) #error due to character or factor in column Diet 

class(ChickWeight$Diet)

sapply(ChickWeight,class)

ChickWeight$weight <- as.numeric(ChickWeight$weight)
ChickWeight$Time <- as.numeric(ChickWeight$Time)
ChickWeight$Diet <- as.numeric(ChickWeight$Diet)
ChickWeight$Chick <- as.numeric(ChickWeight$Chick)
ChickWeight <- sapply(ChickWeight, as.numeric)

apply(ChickWeight,2, sum)
apply(ChickWeight,2, mean)

lapply(ChickWeight[,1],mean)
lapply(list(ChickWeight[,1]),mean)


a <- lapply(ChickWeight$weight,FUN = function(x) x^2)
a
b <- lapply(list(ChickWeight$weight),FUN = function(x) x^2)
b


a <- sapply(ChickWeight$weight,FUN = function(x) x^2)
a
b <- sapply(list(ChickWeight$weight),FUN = function(x) x^2)
b

with(ChickWeight,sapply(weight,function(x) x^2))



a <- vapply(ChickWeight$weight,FUN = function(x) x^2,numeric(1))
a
b


with(ChickWeight,mapply(function(x,y) x/y,weight,Chick))


a <- tapply(ChickWeight$weight, ChickWeight$Diet, mean)
a
b <- tapply(ChickWeight$weight, ChickWeight$Diet, max)
b


aggregate(ChickWeight$weight, list(diet = ChickWeight$Diet), mean) #mean weight depending on all the diet
aggregate(weight ~ Diet, ChickWeight,mean)
?aggregate
aggregate(ChickWeight$weight, list(time = ChickWeight$Time), mean)


a <- by(ChickWeight$weight,ChickWeight$Diet,mean)
a
?by

b <- by(ChickWeight,ChickWeight$Diet,colMeans)
b

l1 <- list(a = 1:10, b = 11:20,c = c('d','a','t','a'))
l1


#same as mapply recursive apply
?rapply
rapply(l1,mean, how = "unlist", classes = "integer")

rapply(l1,mean, how = "list", classes = "integer")

rapply(l1,mean, how = "replace", classes = "integer")

rapply(ChickWeight, mean)


#maps sums to all the list = 1+1+1, 2+2+2 etc summing position wise
Map(sum, 1:5,1:5,1:5)
Map(sum, 1:5,6:9,11:15) #warning 


?new.env()
#creating an environment
e <- new.env()
e$n1 = 100
e$n2 = 144

?eapply
eapply(e,sqrt)

install.packages("tidyverse")
install.packages("hflights")
library(tidyverse)
#several functions in dplyr
dplyr::

library(hflights)
ls()
data(hflights)
str(hflights)


hflights <- as_tibble(hflights)
print(hflights,n=10)

#flights for 1st month 1st Date means 1st Jan
temp <- hflights[hflights$Month==1 & hflights$DayofMonth==1,]
temp1 <- filter(hflights, Month==1, DayofMonth==1)

#filter present in stats and dplyr both library
?filter
#use filter in this way by specifying library name for efficient and correct use
dplyr::filter()
stats::filter()


carr <- filter(hflights, UniqueCarrier=="AA" | UniqueCarrier=="UA")
carr1 <- filter(hflights, UniqueCarrier %in% c("AA","UA"))


mon <- filter(hflights, Month == max(Month))

#accessing columns
hflights[,c("DepTime","ArrTime","FlightNum")]
select(hflights,DepTime,ArrTime,FlightNum) #selects specified columns for all the rows

select(hflights,Year:DayofMonth)
#columns from Year to Day of Months along with column containing taxi and delay in its name
select(hflights,Year:DayofMonth,contains("Taxi"),contains("Delay")) 

?select

#columns excluding from Year to DayofMonth using ! and -
select(hflights,!(Year:DayofMonth))
select(hflights,-(Year:DayofMonth))

#ends with condition in select
select(hflights,ends_with('Delay'))

#selecting and then filtering
filter(select(hflights,UniqueCarrier,DepDelay), DepDelay>60)

#more readability %>% indicates passing through the output
hflights %>% select(UniqueCarrier,DepDelay) %>% filter(DepDelay > 60)


hflights %>% select(UniqueCarrier,DepDelay) %>% filter(between(DepDelay,40,80))

hflights %>% filter(!is.na(DepDelay))

#false in R because of slight deviation from answer
sqrt(2)^2 == 2
(1/49)*(49) == 1


#to avoid above error use near function from dplyr library
near(sqrt(2)^2,2)



x1 <- 1:5
x2 <- 2:6
sqrt(sum((x1-x2)^2))
sqrt(5)

#piping for simplification
(x1-x2)^2 %>% sum() %>% sqrt()


#renaming column
hflights <- hflights %>% rename(Cancellation = CancellationCode)


hflights[order(hflights$DepDelay),c("UniqueCarrier","DepDelay")]
#descending order arrangement
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay))
#ascending order arrangement
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(DepDelay)


hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice(5:10)
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice_head(n=5)
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice_tail(n=5)
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice_sample(n=5)


hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice_max(DepDelay,n=5)
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(desc(DepDelay)) %>% slice_min(DepDelay,n=5)


#one ascending other descending
hflights %>% select(UniqueCarrier,DepDelay) %>% arrange(UniqueCarrier,desc(DepDelay)) 

#calculating columns
hflights$Speed = hflights$Distance / hflights$AirTime * 60
#mutate add all columns
b <- hflights %>% select(Distance,AirTime) %>% mutate(Speed = Distance/AirTime * 60)
b
#transmute adds specific calculated column
a <- hflights %>% select(Distance,AirTime) %>% transmute(Speed = Distance/AirTime * 60)
a

#mean on delay group by dest
with(hflights, tapply(ArrDelay, Dest, mean, na.rm = TRUE))
aggregate(ArrDelay ~ Dest, hflights,mean)
hflights %>% group_by(Dest) %>% summarise(avg_delay = mean(ArrDelay, na.rm=TRUE))          
hflights %>% group_by(Dest) %>% summarise(x = mean(ArrDelay, na.rm=TRUE))



temp <- hflights %>% group_by(Dest) %>% summarise(across(where(is.numeric),mean,na.rm=T)) 
temp


hflights %>% group_by(Dest) %>% summarise(across(starts_with('Taxi'),sum,na.rm=T))

hflights %>% group_by(Dest) %>% summarise(across(starts_with('Taxi'),list(sum=sum,mean=mean),na.rm=T))

hflights %>% group_by(Dest) %>% 
  summarise(across(starts_with('Taxi'),list(sum=sum,mean=mean),na.rm=T,.names ="{.fn} of {.col}" ))

temp <- hflights %>% mutate(across(where(is.numeric),~./100))
temp

hflights %>% group_by(Month,DayofMonth) %>% summarise(flight_count = n()) %>% arrange(desc(flight_count))
hflights %>% group_by(Month,DayofMonth) %>% tally(sort = TRUE)

hflights %>% group_by(Dest) %>% summarise(flight_count = n(), plane_count = n_distinct(TailNum))
hflights %>% group_by(Dest) %>% 
  summarise(flight_count = n(), plane_count = n_distinct(TailNum),perc=n()/n_distinct(TailNum))

hflights %>% group_by(Dest) %>% select(Cancelled) %>% table() %>% head()

hflights %>% group_by(Dest) %>% select(Cancelled) %>% table()  


hflights %>% select(Dest,Cancelled) %>% group_by(Dest) %>% 
transmute(cratio = sum(Cancelled)/n()) %>% ungroup %>% distinct() %>% 
arrange(cratio) %>% slice_tail(n=5)

#top based on Unique Carrier
hflights %>% 
  group_by(UniqueCarrier) %>% 
  select(Month,DayofMonth,DepDelay) %>% 
  top_n(4) %>% 
  arrange(UniqueCarrier,desc(DepDelay))

#shifting data
lag(hflights$Speed)
lead(hflights$Speed)

#shifting data by a specific number
lag(hflights$Speed,1)
lead(hflights$Speed,1)

#checking count of flight monthly using lag to find increase or decrease in count
hflights %>%
  group_by(Month) %>%
  summarise(flight_count=n()) %>%
  mutate(change = flight_count - lag(flight_count))

#checking count of flight monthly using lag to find percentage increase or decrease in count
hflights %>%
  group_by(Month) %>%
  summarise(flight_count=n()) %>%
  mutate(change = (flight_count - lag(flight_count))/lag(flight_count))*100

#use of tally in case of summarise
hflights %>%
  group_by(Month) %>%
  tally() %>% 
  mutate(change = n - lag(n))
?tally

#sampling random 5 rows out of dataset
hflights %>% sample_n(5)


#randomly selects 25 percent and replace T indicates that repeated values can occur in result
a <- hflights %>% sample_frac(0.25,replace=T)
a

#randomly selects 25 percent and replace F indicates that repeated values can not occur in result
#only unique result
b <- hflights %>% sample_frac(0.25,replace=F)
b
?sample_frac



