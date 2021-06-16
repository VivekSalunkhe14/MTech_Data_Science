#question 1
qty <- as.integer(readline("Enter the Qty: "))
prc <- as.integer(readline("Enter the Price: "))
if(qty>25 & prc > 5000) {
  print(prc - 0.1*(prc))
}else if(qty>25 | prc > 5000){
  print(prc - 0.05*(prc))
}else{
  print(prc)
}

disc <- function(quantity, price, discount = 0){
  if (quantity > 25 && price >5000){
    final_price = price - price*(10/100)
  }
  else if(quantity > 25 || price >5000){
    final_price = price - price*(5/100)
  } 
  else {
    final_price = 0
  }
  return (final_price)
}
var = disc(30, 10000)
var


#question 2
data(iris)
versicolor <- iris[iris$Species=="versicolor",]
versicolor['diff'] <-  versicolor$Sepal.Length - versicolor$Sepal.Width


library(ggplot2)
ggplot(df_versicolor,aes(x=diff)) +
  geom_histogram()

mean <- colMeans(Filter(is.numeric,versicolor),na.rm = TRUE)
mean

df.car_0_60_time <- read.csv("car_0_60_time.csv")
df.car_engine_size <- read.csv("car_engine_size.csv")
df.car_horsepower <- read.csv("car_horsepower.csv")
df.car_power_to_weight <- read.csv("car_power_to_weight.csv")
df.car_top_speed <- read.csv("car_top_speed.csv")
df.car_torque <- read.csv("car_torque.csv")

all_dfs <- list(time=df.car_0_60_time, eng=df.car_engine_size, horse=df.car_horsepower,ptw=df.car_power_to_weight, ts=df.car_top_speed, tor=df.car_torque)
all_dfs

for(i in 1:length(all_dfs)){
  all_dfs[[i]] <- distinct(all_dfs[[i]], car_full_nm, .keep_all=TRUE)
}

all_dfs[[1]]

library(dplyr)
df.car_0_60_time %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)
df.car_engine_size %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)
df.car_horsepower %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)
df.car_power_to_weight %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)
df.car_top_speed %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)
df.car_torque %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count != 1)

df.car_0_60_time  <- distinct(df.car_0_60_time,car_full_nm,.keep_all = TRUE)
df.car_engine_size <- distinct(df.car_engine_size,car_full_nm,.keep_all = TRUE)
df.car_horsepower  <- distinct(df.car_horsepower,car_full_nm,.keep_all = TRUE)
df.car_power_to_weight  <- distinct(df.car_power_to_weight,car_full_nm,.keep_all = TRUE)
df.car_top_speed  <- distinct(df.car_top_speed,car_full_nm,.keep_all = TRUE)
df.car_torque  <- distinct(df.car_torque,car_full_nm,.keep_all = TRUE)

df.car_spec_data <- left_join(df.car_horsepower,df.car_torque,by="car_full_nm")
df.car_spec_data <- left_join(df.car_spec_data,df.car_engine_size,by="car_full_nm")
df.car_spec_data <- left_join(df.car_spec_data,df.car_0_60_time,by="car_full_nm")
df.car_spec_data <- left_join(df.car_spec_data,df.car_power_to_weight,by="car_full_nm")
df.car_spec_data <- left_join(df.car_spec_data,df.car_top_speed,by="car_full_nm")

names(all_dfs)

cars <- left_join(all_dfs[['horse']],
                  all_dfs[['tor']],
                  by="car_full_nm")
all_dfs_names <- names(all_dfs)
all_dfs_names

for(i in 1:length(all_dfs)){
  if(all_dfs_names[i] != 'horse' &
     all_dfs_names[i] != 'tor'){
    cars <- left_join(cars, all_dfs[[i]], by="car_full_nm")
  }
}

all_dfs[['horse']]

test <- left_join(all_dfs[['horse']],all_dfs[['tor']],by="car_full_nm") %>% 
  left_join(.,all_dfs[['eng']],by="car_full_nm") %>% 
  left_join(.,all_dfs[['time']],by="car_full_nm") %>% 
  left_join(.,all_dfs[['ptw']],by="car_full_nm") %>% 
  left_join(.,all_dfs[['ts']],by="car_full_nm")

?sub
df.car_spec_data <- mutate(df.car_spec_data, year=sub(".*\\[([0-9]{4})\\]","\\1",car_full_nm))
cars <- mutate(cars, year=sub(".*\\[([0-9]{4})\\]","\\1",car_full_nm))
df.car_spec_data <- mutate(df.car_spec_data,
                           decade = as.factor(
                             ifelse(substring(df.car_spec_data$year,1,3)=='193','1930s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='194','1940s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='195','1950s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='196','1960s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='197','1970s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='198','1980s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='199','1990s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='200','2000s',
                             ifelse(substring(df.car_spec_data$year,1,3)=='201','2010s',"Error"
                             )))))))))
))

#try

cars$year <- as.numeric(cars$year)

# function to calculate decade
cars$decade <- (cars$year %/% 10) * 10
cars$decade <- as.character(cars$decade)
cat <- mutate(df.car_spec_data,
              decade = paste0(substring(df.car_spec_data$year,1,3)),'0s')
cat


df.car_spec_data <- mutate(df.car_spec_data,make_nm=gsub(" .*$","",car_full_nm))

df.car_spec_data <- mutate(df.car_spec_data, car_weight_tons = horsepower_bhp/horsepower_per_ton_bhp)
df.car_spec_data <- mutate(df.car_spec_data, torque_per_tons = torque_lb_ft/car_weight_tons)

df.car_spec_data %>% group_by(decade) %>% summarise(count=n()) 
table(df.car_spec_data$decade)

df.car_spec_data %>% group_by(make_nm) %>% summarise(make_count=length(make_nm)) %>% 
  arrange(desc(make_count))

#optional
df.car_spec_data <- as.character(df.car_spec_data$year)

df.car_spec_data <- as.data.frame(df.car_spec_data)
library(ggplot2)
ggplot(data=df.car_spec_data,aes(x=horsepower_bhp, y=top_speed_mph)) + 
  geom_point(alpha=0.4,size=4,color="#880011") +
  ggtitle("HP vs TS") + 
  labs(x="Hp,bhp",y="TS,\nmph")


ggplot(data=df.car_spec_data,aes(x=top_speed_mph)) + 
  geom_histogram(fill="#880011") +
  ggtitle("Histogram") + 
  labs(x="TS mph",y="Count")

df.car_spec_data %>%
  filter(top_speed_mph>149 & top_speed_mph<159) %>%
  ggplot(aes(x=as.factor(top_speed_mph))) +
  geom_bar(fill="#880011") + 
  labs(x = "TS mph")

ggplot(data=df.car_spec_data,aes(x=top_speed_mph)) + 
  geom_histogram(fill="#880011") +
  ggtitle("Histogram") + 
  labs(x="TS mph",y="Count") + 
  facet_wrap(~decade)


df.car_spec_data %>%
  filter(top_speed_mph==155 & year>=1990) %>%
  group_by(make_nm) %>%
  summarise(count_speed_controlled = n()) %>% 
  arrange(desc(count_speed_controlled))

yr <- df.car_spec_data %>%
  filter(top_speed_mph==155 & year>=1990) %>%
  group_by(year) %>%
  summarise(count_speed_controlled = n()) %>% 
  arrange(desc(count_speed_controlled))

df.car_spec_data %>% 
  group_by(year) %>%
  summarise(max_speed = max(top_speed_mph, na.rm = TRUE)) %>%
  ggplot(aes(x=year,y=max_speed,group=1)) + 
  geom_point(size=5,alpha=0.8,color="#880011") + 
  stat_smooth(method = "auto",size=1.5) + 
  scale_x_discrete(breaks = c("1950","1960","1970","1980","1990","2000","2010")) + 
  ggtitle("Spread of years \n Fastest Car by Years") + 
  labs(x="Year",y="Top Speed\n(fastest car)")


?reorder
df.car_spec_data %>%
  select(car_full_nm,top_speed_mph) %>% 
  filter(min_rank(desc(top_speed_mph))<=10) %>%
  arrange(desc(top_speed_mph)) %>% 
  ggplot(aes(x=reorder(car_full_nm,top_speed_mph),y=top_speed_mph)) + 
  geom_bar(stat = "identity", fill="#880011") +
  coord_flip() +                                  #flips x and y axis
  ggtitle("Top 10 Fastest Cars (through 2012)") + 
  labs(x="", y="") + 
  theme(axis.text.y = element_text(size=rel(1.5))) +   #increase the font size of text
  theme(plot.title = element_text(hjust=1))  #aligns the title


ggplot(data=df.car_spec_data,aes(x=horsepower_bhp,y=car_0_60_time_seconds)) +
  geom_point()

ggplot(data=df.car_spec_data,aes(x=horsepower_bhp,y=car_0_60_time_seconds)) +
  geom_point(position = "jitter")
  
ggplot(data=df.car_spec_data,aes(x=horsepower_bhp,y=car_0_60_time_seconds)) +
  geom_point(size=4,alpha=0.7,color="#880011",position = "jitter") + 
  stat_smooth(method = "auto",size=1.5) + 
  ggtitle("0 to 60 times by Horsepower") + 
  labs(x="Horsepower, bhp",y="0-60 time\nseconds")

ggplot(data=df.car_spec_data,aes(x=df.car_spec_data$torque_per_ton,y=car_0_60_time_seconds)) +
  geom_point(size=4,alpha=0.7,color="#880011",position = "jitter") + 
  stat_smooth(method = "auto",size=1.5) + 
  ggtitle("0 to 60 times by Horsepower") + 
  labs(x="Horsepower, bhp",y="0-60 time\nseconds")









