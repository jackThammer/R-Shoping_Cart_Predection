df_groceries <- read.csv("Original_dataset.csv")

df_sorted <- df_groceries[order(df_groceries$Member_number),]
df_sorted$Member_number <- as.numeric(df_sorted$Member_number)

if(sessionInfo()['basePkgs']=="dplyr" | sessionInfo()['otherPkgs']=="dplyr"){
  detach(package:dplyr, unload=TRUE)
}
library(plyr)

df_itemList <- ddply(df_groceries,c("Member_number","Date"), 
                     function(df1)paste(df1$itemDescription, 
                                        collapse = ","))

df_itemList$Member_number <- NULL
df_itemList$Date <- NULL

#Rename column headers for ease o use
colnames(df_itemList) <- c("itemList")
write.csv(df_itemList,"Recreated_Dataset.csv", row.names = TRUE,quote = FALSE)

library(arules)
txn = read.transactions(file="Recreated_Dataset.csv", rm.duplicates= TRUE, format="basket",sep=",",cols=1)
txn@itemInfo$labels <- gsub("\"","",txn@itemInfo$labels)

basketo<-apriori(txn,parameter = list(supp = 0.01, conf = 0.001,minlen=2))
if(sessionInfo()['basePkgs']=="tm" | sessionInfo()['otherPkgs']=="tm"){
  detach(package:tm, unload=TRUE)
}
inspect(basketo)

df_basket <- as(basketo,"data.frame")
View(df_basket)
write.csv(df_itemList,"2_Predicted_Data.csv", row.names = TRUE,quote = FALSE)

#Split the data into two diffrent coloums
library(stringr)
write.csv(str_split_fixed(df_basket$rules, " => ", 2),"1_Final_Data.csv", row.names = TRUE,quote = FALSE)

#df_basket[] <- lapply(df_basket, gsub, pattern='{', replacement='')

dataset=str_split_fixed(df_basket$rules, " => ", 2)


#Insert into SQL table
install.packages("RMySQL")
library(DBI)


con=dbConnect(RMySQL::MySQL(),dbname="local_schema",host="localhost",port=3306,user="root",password="")

dbWriteTable(conn = con, name = 'dataset', value = as.data.frame(dataset))


