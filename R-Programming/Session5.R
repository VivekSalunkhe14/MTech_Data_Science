library(dplyr)

library(hflights)
summary(hflights)
glimpse(hflights)

#install.packages("RSQLite")
library(RSQLite)

#database connection made
con <- DBI::dbConnect(RSQLite::SQLite(),":memory:")

#attaching hflights to con
copy_to(con,hflights)
hflights_db <- con %>% tbl("hflights")
hflights_db

query <- con %>% tbl(sql("SELECT * FROM hflights WHERE DepTime=1400"))
query

rm(list=ls())

#group by
a <- hflights %>% group_by(Month, DayofMonth) %>% top_n(3,DepDelay)
a

#unique and distinct 
hflights %>% select(Origin,Dest) %>% unique() %>% arrange(Origin)
hflights %>% select(Origin,Dest) %>% distinct()

(a <- tibble(color=c("green","yellow","red"), num=1:3))
(b <- tibble(color=c("green","yellow","black"), price=c(50,110,140)))


inner_join(a,b)#common elements
full_join(a,b) #all elememnts
left_join(a,b) #all elements from a dataset
right_join(a,b) #all elements from b dataset
semi_join(a,b) #common elements or all values in a and also in b
anti_join(a,b) #uncommon elements or all values in a not in b


data("hflights")
str(hflights)

#positioning column to start
temp <- hflights %>% relocate(UniqueCarrier)

temp <- hflights %>% relocate(UniqueCarrier, .after=FlightNum)

temp <- hflights %>% relocate(UniqueCarrier, .before=DepTime)
temp <- hflights %>% relocate(UniqueCarrier, .after=last_col())
temp <- hflights %>% relocate(where(is.character))
                              
hflights %>% mutate(total = rowSums(across(where(is.numeric))))
hflights %>% mutate(total = rowMeans(across(where(is.numeric))))
                              
install.packages("lubridate")                              
library(lubridate)                              
                              
today()
now()                                                            

#functions under lubridate

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")
ymd(20170131)
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")


install.packages("nycflights13")
library(nycflights13)
data("flights")


flights %>% select(year, month, day, hour, minute)

temp <- flights %>% select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

flights$dep_time %/% 100
flights$dep_time %% 100

  make_datetime_cust <- function(year, month, day, time){make_datetime(year, month, day, time%/%100, time%%100)}

flights_df <- flights %>% filter(!is.na(dep_time),!is.na(arr_time)) %>%
              mutate(
                dep_time = make_datetime_cust(year, month, day, dep_time),
                arr_time = make_datetime_cust(year, month, day, arr_time),
                sched_dep_time = make_datetime_cust(year, month, day, sched_dep_time),
                sched_arr_time = make_datetime_cust(year, month, day, sched_arr_time)
              ) %>% 
              select(origin,dest,ends_with("delay"),ends_with("time"))


datetime <- ymd_hms("2016-07-08 12:34:56")
year(datetime)
month(datetime)
month(datetime,label=TRUE)
month(datetime,label=TRUE,abbr = F)
day(datetime)
mday(datetime)
yday(datetime)
wday(datetime)
wday(datetime, label=TRUE, abbr = F)

year(datetime) <- 2020
datetime
month(datetime) <- 01
datetime
hour(datetime) <- hour(datetime)+1 
datetime


update(datetime, year=2020, month=2, mday=2, hour=2)
datetime

#feb has no 30 date so it goes 2 days forward in march
ymd("2015-02-01") %>% update(mday=30)

#updating date by increasing hours by 400 
ymd("2015-02-01") %>% update(hours=400)


#operations
today() - ymd(20000101) #no of days
temp <- today() - ymd(20000101) #no of days
temp
as.duration(temp) #gives no of days in seconds and approximations in terms of year

#operations on minutes and seconds
# anything with d at start converts corresponding values to seconds
dseconds(15)
seconds(15)

dminutes(10)
minutes(10)

dhours(c(12,24))
hours(c(12,24))

ddays(0:5)
days(0:5)

dweeks(3)
weeks(3)

dyears(1)
years(1)

months(1)

2 * dyears(1)
ymd(20170131, tz = "UTC")
ymd_hms("2016-07-08 12:34:56", tz = "Asia/Kolkata")

#missed part
library(ggplot2)
data(mpg)

ggplot(mpg, aes(x=displ, y =hwy)) #aes-aesthatics

ggplot(mpg,aes(x=displ, y = hwy))+
  geom_point() #geom_ various plots

ggplot(mpg,aes(displ, hwy))+
  geom_point() #best syntax for this according to author

ggplot(mpg,aes(displ, hwy))+
  geom_point()+
  geom_line()#tp

?ggplot

ggplot(mpg, aes(displ,cty,colour=class))+geom_point()
ggplot(mpg, aes(displ,cty,shape=drv))+geom_point()
ggplot(mpg, aes(displ,cty,size=cyl))+geom_point()
ggplot(mpg, aes(displ,cty,colour=class,shape=drv))+geom_point()#noisy
ggplot(mpg, aes(displ,hwy)) + geom_point(aes(color="blue"))
ggplot(mpg, aes(displ,hwy)) + geom_point(color="blue")

ggplot(mpg)+geom_point(aes(displ,hwy))
ggplot(mpg, aes(displ,hwy)) + geom_point(colour="blue")

#facetting: multiple charts
?ggplot
ggplot(mpg, aes(displ,hwy)) + geom_point() + facet_wrap(~class)
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth() + facet_wrap(~year)


?geom_smooth

#confidence interval or band is removed
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(se=F) #band is removed

#span considers all the dots in between and hence makes plot less smoother
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(span=0.2)
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(span=0.5)
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(span=1)



#install.packages("mgcv")
#install.packages("MASS")
library(mgcv)
library(MASS)
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(method="gam", formula = y~s(x))
ggplot(mpg, aes(displ,hwy)) + geom_point() + geom_smooth(method="rlm")

#jitter
ggplot(mpg, aes(drv,hwy)) + geom_point()

ggplot(mpg, aes(drv,hwy)) + geom_jitter()

ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.1)

ggplot(mpg, aes(drv,hwy,colour=class)) + geom_jitter(width = 0.1)


#boxplot and violin
ggplot(mpg, aes(drv,hwy)) + geom_boxplot()

ggplot(mpg, aes(drv,hwy)) + geom_violin()

#histogram
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2.5)
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 5)
ggplot(mpg, aes(hwy,color=drv)) + geom_histogram(binwidth = 5)
ggplot(mpg, aes(hwy,fill=drv)) + geom_histogram(binwidth = 5)
ggplot(mpg, aes(hwy,fill=drv)) + geom_histogram(binwidth = 0.5)+facet_wrap(~drv,ncol=1)
ggplot(mpg, aes(displ,fill=drv)) + geom_histogram(binwidth = 0.5)+facet_wrap(~drv,nrow=2)

#frequeny polygon
ggplot(mpg, aes(hwy)) + geom_freqpoly()
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth = 2.5)
ggplot(mpg, aes(hwy,color=drv)) + geom_freqpoly(binwidth = 2.5)


#bar plot if y not specified it by defaults gives count of values present on x line
#by default stat = count
ggplot(mpg,aes(manufacturer))+geom_bar()


#new df
drugs <- data.frame(
  drug = c("a","b","c"),
  effect = c(4.2,9.7,6.1)
)

#plots y along given x values instead of count <- stat=identity
ggplot(drugs, aes(drug,effect))+geom_bar(stat="identity")

data("economics")
str(economics)

ggplot(economics, aes(date, unemploy/pop)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_line()
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_line()+geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics,aes(unemploy/pop, uempmed))+geom_path(colour="grey50")+ geom_point(aes(colour=year(date)))


ggplot(mpg, aes(cty,hwy)) + geom_point(alpha=0.1)
ggplot(mpg, aes(cty,hwy)) + geom_point(alpha=1/3) + xlab("city") + ylab("highway")
ggplot(mpg, aes(cty,hwy)) + geom_point(alpha=1/3) + xlab(NULL) + ylab(NULL)


ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25)
ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25) + xlim("f","r") + ylim(20,30)
ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25) + ylim(30) #error
ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25) + ylim(NA,30)
ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25) + ylim(0,30)
ggplot(mpg, aes(drv,hwy)) + geom_jitter(width = 0.25,na.rm=TRUE) + ylim(30,NA)

p <- ggplot(mpg, aes(displ,hwy,colour=factor(cyl))) + geom_point()

print(p)
?saveRDS

setwd("D:/R")
saveRDS(p, "plot.rds")
q <- readRDS("plot.rds")
q + xlab('Displacement')

getwd()

#saves most recent chart in the working directory
ggsave("plot.png", width=8, height=5, dpi=300)
summary(p)
q + geom_smooth()


#quickplot
?qplot
qplot(displ, hwy, data=mpg)
qplot(displ, data=mpg)

qplot(displ, hwy, data=mpg, colour="blue")
qplot(displ, hwy, data=mpg, colour=I("blue"))

df <- data.frame(
  x = c(3,1,5),
  y = c(2,4,6),
  label = c("a","b","c")
)


p <- ggplot(df, aes(x,y, label=label)) + labs(x=NULL,y=NULL) + theme(plot.title = element_text(size=12))
p

df <- data.frame(x=1, y=3:1, family=c("sans","serif","mono"))
ggplot(df,aes(x,y)) + geom_text(aes(label=family, family=family))


#install.packages("directlabels")
library(directlabels)

data("presidential")
data("economics")
presidential <- subset(presidential, end > economics$date[1])


ggplot(economics) +
  geom_rect(
    aes(xmin=start,xmax=end, fill=party),
    ymin=-Inf, ymax=Inf,alpha=0.2,
    data=presidential
  )+
  geom_vline(
    aes(xintercept = as.numeric(start)),
    data = presidential,
    colour="grey50", alpha=0.5
  )+
  geom_text(
    aes(x=start,y=max(economics$unemploy)+200,label=name),
    data = presidential,
    size=3,vjust=0,hjust=0,nudge_x = 50
  )+
  geom_line(aes(date,unemploy))+
  scale_fill_manual(values = c("blue","red"))


?geom_text
ggplot(economics, aes(date,uneploy))+
  geom_line()+
  annotate("text")





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
