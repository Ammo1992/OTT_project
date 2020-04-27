#Packages used
install.packages("dplyr")
library("dplyr") #for data manipulation

install.packages("conjoint")
library("conjoint") 

#Loading the dataset
ottdata <- read.csv("OTT_Data.csv")

#reordering the data to make it consistent with the profile matix generated below
#to get the desired results from the conjoint analysis
reorderdata <- data.frame( ottdata$q_3.3 , ottdata$q_3.6, ottdata$q_3.10 , 
                           ottdata$q_3.1 , ottdata$q_3.8 , ottdata$q_3.12 , 
                           ottdata$q_3.4 , ottdata$q_3.5 , ottdata$q_3.9 , 
                           ottdata$q_3.2 , ottdata$q_3.7 , ottdata$q_3.11 )

#loading the reorderd dataframe back into the main data frame
ottdata[11:22] <- reorderdata 

#levels vector - as in the values each variable can take i.e. brand, price and ads
ottlev <- c("Netflix", "Amazon Prime", "Hotstar" ,"Rs. 999", "Rs. 4799", "10 sec", "60 sec")

#profile matrix - as in the various combinations of the variables possible
ottprof <- expand.grid(brand=c("Netflix","Amazon Prime","Hotstar"),  
                       price=c("Rs. 999","Rs. 4799"),  
                       ad=c("10 sec","60 sec"))

#the Conjoint Analysis of Total data
Conjoint(y=ottdata[11:22], x=ottprof, z=ottlev)

#the Conjoint Analysis of Males data
Conjoint(y=filter(ottdata,q_7==1) %>% select(11:22), x=ottprof, z=ottlev)

#the Conjoint Analysis of Females data
Conjoint(y=filter(ottdata,q_7==2) %>% select(11:22), x=ottprof, z=ottlev)

#the Conjoint Analysis of Students data
Conjoint(y=filter(ottdata,q_9==1) %>% select(11:22), x=ottprof, z=ottlev)

#the Conjoint Analysis of Working professionals data
Conjoint(y=filter(ottdata,q_7==2) %>% select(11:22), x=ottprof, z=ottlev)