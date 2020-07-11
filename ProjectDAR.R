library(dplyr)
df<- read.csv("googleplaystore.csv")
View(df)
head(df)
summary(df)
#to filter the variables

head(filter(df, Installs<50000,Type=="Free"))

# Shift the values to another data frame 

db<- slice(df,1:20)
View(db)

#rename a row

df<- rename(db, Category=section)
View(df)

X<- 10
db<-mutate(df,Dicount=Price*X)

View(db)

summarise(db,Rate_avg=mean(Rating))

distinct(select(df,Genres))
distinct(select(db,Rating))
sample_n(db,5)







install.packages('corrgram')
install.packages('corrplot')


#Data Visualization

library(ggplot2)
library(corrgram)
library(corrplot)
ggplot(db,aes(x=Rating,y=Reviews,fill=Rating))+geom_bar(stat="identity")+ggtitle("Overall Performance ")+ylab("Reviews")+xlab("Rating")
Col<-sapply(db,is.numeric)
cor.data<- cor(db[,Col])
corrplot(cor.data, method = 'square', type='upper')

#Create another way of visualisation
box<-ggplot(dm,aes(x=Region,y=Happiness.Score, color=Region))
box+geom_boxplot()+geom_jitter(aes(color=Country),size=1.0)+ggtitle("overall Rating")+coord_flip()+theme(legend.position = "none")
View(dm)
#box 
ggplot(dm,aes(x=continent,y=Happiness.score,color=continent))+geom_boxplot()+ggtitle("Overall Rating")
#classify all of the data based on happiest neutral and least happy region
db$happinessmeter<-NA
db$happinessmeter[which(db$Region%in%c("Australia and Newzeland","westernEurope"))]<-"Happiest"
#plot regresson For the 
ggplot(db,aes(x=Health..Life.Expectancy., y=Happiness.score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter),method = 'lm',fullrange=T)+facet_wrap(happinessmeter)+theme_bw()