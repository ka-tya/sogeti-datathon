setwd("C:/Users/khuster/Documents/C3 Hackathon")
customers <- read.csv("./dunnhumby_The-Complete-Journey/CSV/hh_demographic.csv")

#explore data
head(customers)
str(customers)
#check for NAs
any(is.na(customers)) #none

#order income desc correctly
customers$INCOME_DESC_order <- factor(customers$INCOME_DESC,c("Under 15K","15-24K", "25-34K","35-49K", "50-74K",
                                                              "75-99K", "100-124K",  "125-149K", "150-174K","175-199K", 

                                                                                                                            "200-249K", "250K+"))
library(ggplot2)
c<- ggplot(customers, aes(INCOME_DESC_order))
c+geom_bar()
g<- ggplot(customers,aes(AGE_DESC))
g+geom_bar()


#check for clusters
library(klaR)
clusters<- kmodes(customers,5)

#check customer transaction data
#join two tables
transactions <- read.csv("./dunnhumby_The-Complete-Journey/CSV/transaction_data.csv")
transactions$PRODUCT_ID <- as.factor(transactions$PRODUCT_ID)
customer_purchases <- merge(customers,transactions, by = "household_key")

#income vs coupons


aggr <- aggregate(data = customer_purchases, COUPON_DISC~ INCOME_DESC_order, FUN = mean)
g<- ggplot(data = aggr, aes(x = INCOME_DESC_order, y = abs(COUPON_DISC)))
g + geom_bar(stat = "identity")

qplot(INCOME_DESC_order, data = aggr, geom = "bar", weight = abs(COUPON_DISC), ylab = "AVG Coupon Amnt", xlab =  "Income Group")

#age vs coupons
aggr_age <- aggregate(data = customer_purchases, COUPON_DISC~ AGE_DESC, FUN = mean)
qplot(AGE_DESC, data = aggr_age, geom = "bar", weight = abs(COUPON_DISC), ylab = "AVG Coupon Amnt", xlab =  "Age Group")

#most purchased products by qty and sales amnt
##I'm using only retail discount here (not all three discounts, because real price is sales_value ??? (retail_disc + coupon_match_disc))/quantity,
##and the products I'm interested in have no coupon match)
top_products <- aggregate(data = transactions, cbind(SALES_VALUE, QUANTITY, RETAIL_DISC) ~ PRODUCT_ID +WEEK_NO +DAY, FUN = sum)
top_products_aggr <- aggregate(data = top_products, cbind(SALES_VALUE, QUANTITY) ~ (PRODUCT_ID),FUN = sum)
top_sales <- head(top_products_aggr[order(top_products_aggr$SALES_VALUE,decreasing = T),], 5)
top_quantity <-head(top_products_aggr[order(top_products_aggr$QUANTITY,decreasing = T),], 5)

qplot((PRODUCT_ID),data = top_sales,geom = "bar", weight = (SALES_VALUE), ylab = "Total Sales Amnt", xlab = "Product")


#time-series for product '6534178' & '6533889', '1029743'
top_prod <- top_products[which(top_products$PRODUCT_ID  %in% c('6534178','6533889','1029743')),]
top_prod$unit_price <- (top_prod$SALES_VALUE -(top_prod$RETAIL_DISC))/top_prod$QUANTITY

library(forecast)
product_ts1<- ts(top_prod[which(top_prod$PRODUCT_ID =='6534178'),]$SALES_VALUE,frequency= 7)
head(product_ts1, 5)
plot(product_ts1)

# decomposition of the data
product_decomp1<- stl(product_ts1, s.window = "periodic")
plot(product_decomp1)

product_ts2<- ts(top_prod[which(top_prod$PRODUCT_ID =='6533889'),]$SALES_VALUE,frequency= 7)
plot(product_ts2)
                          
# decomposition of the data
product_decomp2<- stl(product_ts2, s.window = "periodic")
plot(product_decomp2)

product_ts3<- ts(top_prod[which(top_prod$PRODUCT_ID =='1029743'),]$SALES_VALUE,frequency= 7)
plot(product_ts3)

# decomposition of the data
product_decomp3<- stl(product_ts3, s.window = "periodic")
plot(product_decomp3)