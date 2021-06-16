library(ggplot2)
data(mpg)
#24-10
ggplot(mpg, aes(class)) + geom_bar()
ggplot(mpg, aes(class)) + geom_bar() + coord_flip()

#drv consists of factor of 3 4 ,r and f hence no group required
ggplot(mpg, aes(class,fill=drv)) + geom_bar()
ggplot(mpg, aes(class,fill=drv)) + geom_bar(position = "stack")
ggplot(mpg, aes(class,fill=drv)) + geom_bar(position = "dodge")
ggplot(mpg, aes(class,fill=drv)) + geom_bar(position = "fill") #gives percentage rather than count

#alpha for opacity
ggplot(mpg, aes(class,fill=drv)) + geom_bar(position = "identity",alpha=1/2,colour="grey50")

#highway contains several values hence group by required
ggplot(mpg, aes(class,fill=hwy)) + geom_bar()
ggplot(mpg, aes(class,fill=hwy,group=hwy)) + geom_bar()
ggplot(mpg, aes(class,fill=hwy,group=hwy)) + geom_bar()


library(dplyr)
install.packages("maps")
library(maps)


mi_counties <- map_data("world", "India")
maps::world.cities
df <- maps::world.cities
mi_cities <- maps::world.cities %>% as_tibble() %>% filter(country.etc=="India") %>% arrange(desc(pop))


ggplot(mi_cities, aes(long,lat)) + 
  geom_point(aes(size=pop)) + 
  scale_size_area() + 
  coord_quickmap()

#use plotly for maps rather than ggplot
ggplot(mi_cities, aes(long,lat)) + 
  geom_polygon(aes(group=group),mi_counties,fill=NA,colour="grey50") + 
  geom_point(aes(size=pop),colour="red") +
  scale_size_area() + 
  coord_quickmap()

data("diamonds")

ggplot(diamonds,aes(color)) + geom_bar()

ggplot(diamonds,aes(color, price)) + geom_bar(stat="summary_bin", fun=mean)
ggplot(diamonds,aes(color, price)) + geom_bar(stat="summary_bin", fun=median)


p <- ggplot(mpg,aes(displ,hwy))
p
p+geom_point()

#substitute to geom_point is layer or geom point actually refers to following
p+layer(
  mapping = NULL,
  data = NULL,
  geom = "point", params = list(),
  stat = "identity",
  position = "identity"
)
?geom_point


df <- data.frame(x=rnorm(2000),y=rnorm(2000))
norm <- ggplot(df,aes(x,y))+ xlab(NULL)+ylab(NULL)
norm
norm+geom_point()
norm+geom_point(shape=1)
norm+geom_point(shape=2)
norm+geom_point(shape='x')
norm+geom_point(shape='.')


ggplot(mpg) + 
  geom_point(aes(displ,hwy,colour=class))


ggplot() + 
  geom_point(data=mpg,aes(displ,hwy,colour=class))


ggplot(mpg,aes(displ,hwy,colour=class)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) + 
  theme(legend.position = "none")

ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) + 
  theme(legend.position = "bottom")


ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) + 
  theme(legend.position = "right")


ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class")
  

ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class") +
  scale_x_continuous()

#shows values in range 4 to 6 on x axis
ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class") +
  scale_x_continuous(breaks = c(4,6)) 


  #shows values in range 4 to 6 on x axis and 20 to 30 on y axis
ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class") +
  scale_x_continuous(breaks = c(4,6)) + 
  scale_y_continuous(breaks = c(20,30))


ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class") +
  scale_x_continuous(breaks = c(4,6), labels = c("Disp4", "Disp6"))

#scales provide multiple functionalities for conversion
scales::label_dollar()(4)
scales::label_percent()(0.5)
scales::label_scientific()(4)


#y axis values are converted into dollars
ggplot(mpg,aes(displ,hwy)) + 
  geom_point(aes(colour=class)) + 
  geom_smooth(method = "lm", se = FALSE) +
  labs(x="Displacement",y="Highway mpg",color="Vehicle Class") +
  scale_x_continuous(breaks = c(4,6), labels = c("Disp4", "Disp6"))+
  scale_y_continuous(labels = scales::label_dollar())


ggplot(mpg,aes(displ, hwy)) +
  geom_point(size=4, colour="grey20") + 
  geom_point(aes(colour=class),size=2)


ggplot(mpg,aes(displ, hwy)) +
  geom_point(aes(colour=class),size=5) +
  geom_point(size=2, colour="grey20") 

#more accurate than above 2
ggplot(mpg,aes(displ, hwy)) +
  geom_point(aes(colour=class),size=5) +
  geom_point(size=2, colour="grey20", show.legend = T) 


norm <- data.frame(x=rnorm(1000),y=rnorm(1000))
norm

#automatically divides data based on x and creates z with labels a, b and c
norm$z <- cut(norm$x, 3, labels = c("a","b","c"))
norm


ggplot(norm,aes(x,y)) + 
  geom_point(aes(colour=z),alpha=0.1)


#keeps the points in the graph with opacity or alpha 0.1 but makes the scale of alpha with opacity 1 
ggplot(norm,aes(x,y)) + 
  geom_point(aes(colour=z),alpha=0.1) +
  guides(colour=guide_legend(override.aes = list(alpha=1)))


p <- ggplot(mpg,aes(displ, hwy)) +
  geom_point(aes(colour=class),size=5) +
  geom_point(size=2, colour="grey20", show.legend = T) 
p

#positioning the legend inside chart use theme
p+theme(legend.position = c(0,1),legend.justification = c(0,1))

#legend positioned from left
p+theme(legend.position = c(0.5,0.5),legend.justification = c(1,1))

#legend positioned from right 
p+theme(legend.position = c(0.5,0.5),legend.justification = c(-1,1))

p+theme(legend.position = c(0.5,0.5),legend.justification = c(0,0))

#perfect position
p+theme(legend.position = c(1,1),legend.justification = c(1,1))

p+theme(legend.position = c(1,0),legend.justification = c(1,0))

p+theme(legend.position = c(0,0),legend.justification = c(-1,0))


base <- ggplot(mtcars,aes(factor(1),fill=factor(cyl))) + 
  geom_bar(width = 1) + 
  theme(legend.position = "none") + 
  scale_x_discrete(NULL,expand = c(0,0)) + 
  scale_y_continuous(NULL,expand = c(0,0))
base


base+ coord_polar(theta="y")
base+ coord_polar()
?coord_polar
?theme_set

theme_set(theme_classic())
mpg
df <- as.data.frame(table(mpg$class))
df
colnames(df) <- c("class","freq")

pie <- ggplot(df,aes(x="",y=freq,fill=factor(class))) + 
  geom_bar(width = 1, stat = "identity") + 
  theme(axis.line = element_blank(),plot.title = element_text(hjust = 0.5)) + 
  labs(fill="class", x= NULL, y= NULL, title="Pie Chart of Class", caption="Source:mpg")

pie

pie+coord_polar(theta = "y",start=0)

pie+coord_polar(theta = "y",start=-90)


#mtcars
theme_set(theme_bw())
data("mtcars")
rownames(mtcars)
mtcars$`car name` <- rownames(mtcars)

#variance from the mean
mtcars$mpg_z <- round((mtcars$mpg-mean(mtcars$mpg))/sd(mtcars$mpg),2)
(mtcars$mpg-mean(mtcars$mpg))/sd(mtcars$mpg)
mtcars$mpg_type <- ifelse(mtcars$mpg_z<0,"below","above")
mtcars <- mtcars[order(mtcars$mpg_z),]
mtcars$`car name` <- factor(mtcars$`car name`,levels=mtcars$`car name`)
ggplot(mtcars,aes(x=`car name`,y=mpg_z,label=mpg_z)) + 
  geom_bar(stat = 'identity', aes(fill=mpg_type),width=0.5) + 
  scale_fill_manual(name="Mileage", labels=c("Above Average","Below Average"),values = c("above"="#00ba38","below"="#f8766d")) +
  labs(subtitle = "Normalised mileage from 'mtcars'", title="Diverging Bars") + 
  coord_flip()



theme_set(theme_classic())
data("mpg")

g <- ggplot(mpg,aes(displ)) + scale_fill_brewer(palette = "Spectral")
g



g+geom_histogram(aes(fill=class),binwidth = 0.2,col="black", size=.1) + 
  labs(title = "Histogrsm with auto binning", subtitle = "Engine disp across vehicle classes")


g+geom_histogram(aes(fill=class),bins = 10,col="black", size=.1) + 
  labs(title = "Histogrsm with auto binning", subtitle = "Engine disp across vehicle classes")

#missed out
g <- ggplot(mpg,aes(manufacturer))
g + geom_bar(aes(fill=class),width = 0.5) + theme(axis.)



plot(iris)
plot(iris$Sepal.Length, iris$Sepal.Width)

ggplot(iris, aes(x=Petal.Length,y=Sepal.Width)) + geom_point()
ggplot(iris, aes(x=Petal.Length,y=Sepal.Width,col=Species)) + geom_point()
ggplot(iris, aes(x=Petal.Length,y=Sepal.Width,col=Species,size=Petal.Width)) + 
  geom_point()
ggplot(iris, aes(x=Petal.Length,y=Sepal.Width,col=Species,size=Petal.Width,shape=Species)) + 
  geom_point()
ggplot(iris, aes(x=Petal.Length,y=Sepal.Width,col=Species,size=Petal.Width,shape=Species,alpha=Sepal.Length)) + 
  geom_point()

#diff betn summary , count ,identity
ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="summary")

ggplot(iris,aes(Species)) + 
  geom_bar(stat="count")

ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="identity")


#plots
ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="summary",fun.y="mean")

ggplot(iris,aes(Species,Sepal.Length,fill=Species)) + 
  geom_bar(stat="summary",fun="mean")

ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="summary",fun="mean", fill="blue")

ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="summary",fun="mean", fill="#ff0080", col="black") + 
  geom_point()


myplot <- ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_bar(stat="summary",fun="mean", fill="#ff0080", col="black") + 
  geom_point(position = position_jitter(0.2),size=3,shape=21)
myplot
myplot + theme(panel.grid = element_blank(),
               panel.background = element_rect(fill="white"),
               panel.border = element_rect(colour="black",fill=NA,size=0.2))


myplot + theme_bw()
myplot + theme_classic()
myplot + theme_dark()
myplot + theme_gray()
myplot + theme_light()
myplot + theme_linedraw() + theme(panel.background = element_rect(fill="blue"))
myplot + theme_minimal()
myplot + theme_void()

ggplot(iris,aes(Species,Sepal.Length)) + 
  geom_point() + 
  geom_boxplot(fill="#ff0800",col="black",notch=TRUE)



myplot +
  theme_bw() + 
  labs(x="", y="Sepal Length(mm)") + 
  ggtitle("Sepal length by iris species") + 
  theme(plot.title = element_text(hjust = 0.5))

ggsave("D:/R/Graph.png",width=8, height=5)


#titanic
titanic <- read.csv('D:/R/titanic.csv',stringsAsFactors = FALSE)
titanic <- read.csv('D:\\R\\titanic.csv',stringsAsFactors = FALSE)
View(titanic)

titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)

#plot of survived and not
ggplot(titanic,aes(x=Survived)) + geom_bar()

#proportion of survived and not survived
table(titanic$Survived)
prop.table(table(titanic$Survived))

ggplot(titanic,aes(x=Survived)) + 
  theme_bw() + 
  geom_bar() + 
  labs(y="Passenger Count", title="Titanic Survival Rates")


ggplot(titanic,aes(x=Sex,fill=Survived)) + 
  theme_bw() + 
  geom_bar() + 
  labs(y="Passenger Count", title="Titanic Survival Rates by Sex")

ggplot(titanic,aes(x=Pclass,fill=Survived)) + 
  theme_bw() + 
  geom_bar() + 
  labs(y="Passenger Count", title="Titanic Survival Rates by Pclass")


#facet wrap for creating multiple graphs based on the condition
ggplot(titanic,aes(x=Sex,fill=Survived)) + 
  theme_bw() + 
  facet_wrap(~Pclass) +
  geom_bar() + 
  labs(y="Passenger Count", title="Titanic Survival Rates by Pclass and Sex")



ggplot(titanic,aes(x=Age)) + 
  theme_bw() + 
  geom_histogram(binwidth = 5) + 
  labs(y="Passenger Count", title="Titanic Age Distribution")



ggplot(titanic,aes(x=Age,fill=Survived)) + 
  theme_bw() + 
  geom_histogram(binwidth = 5) + 
  labs(y="Passenger Count", title="Titanic Survival Rates by Age")


ggplot(titanic,aes(x=Survived,y=Age)) + 
  theme_bw() + 
  geom_boxplot() + 
  labs(y="Age",x="Survived", title="Titanic Survival Rates by Age")


ggplot(titanic,aes(x=Age,fill=Survived)) + 
  theme_bw() + 
  facet_wrap(Sex~Pclass)+
  geom_density(alpha=0.5)+
  labs(y="Age",x="Survived", title="Titanic Survival Rates by Age,Pclass and Sex")



ggplot(titanic,aes(x=Age,fill=Survived)) + 
  theme_bw() + 
  facet_wrap(Sex~Pclass)+
  geom_histogram(binwidth=5)+
  labs(y="Age",x="Survived", title="Titanic Survival Rates by Age,Pclass and Sex")

#additional functions
library(tidyverse)
library(dplyr)

#use to manipulate data
data("USArrests")

USArrests$state <- rownames(USArrests)
str(USArrests)
#single column is replaced for all the columns in USArrests
d1 <- gather(USArrests,
             key = "Crime type",
             value = "Rate",
             -state)


temp <- USArrests %>% gather() %>% group_by()

#spread does the opposite of gather and gives us the original dataset
og <- spread(d1,key = 'Crime type',value='Rate')

numbers=0
x <- as.integer(readline("Enter the count of numbers: "))
for (i in 1:x){
  numbers[i] <- as.integer(readline(paste0("Number", i, ":")))
}
for (i in 1:length(numbers)){
  for (j in 1:length(numbers)){
    if (numbers[i]<numbers[j]){
      temp = numbers[i]
      numbers[i] = numbers[j]
      numbers[j] = temp
    }
  }
}
print("Sorted form:")
for (num in numbers){
  print(num)
}

