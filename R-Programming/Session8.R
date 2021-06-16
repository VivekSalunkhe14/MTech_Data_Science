install.packages("quantmod")
install.packages("lubridate")
install.packages("xlsx")
install.packages("openxlsx")

library(quantmod)
library(xlsx)
library(tidyverse)
library(openxlsx)
library(lubridate)


start <- as.Date('2019-01-01')
end <- as.Date('2020-10-31')

getSymbols('AAPL',src='yahoo',from=start,to=end)

plot(AAPL[,'AAPL.Close'],main='Apple')

#candle chart to monitor up and down movement more efficiently
candleChart(AAPL,up.col='green',dn.col='red',theme = 'white')

#time series data
getSymbols(c('MSFT','GOOG','AAPL','TSLA'),from=start)

#only closing price of each company
stocks <- as.xts(data.frame(AAPL=AAPL[,'AAPL.Close'],GOOG=GOOG[,'GOOG.Close'],MSFT=MSFT[,'MSFT.Close'],
                            TSLA=TSLA[,'TSLA.Close']))


write.xlsx(MSFT,"MSFT.xlsx",col.names=TRUE)

plot(as.zoo(stocks),screens = 1,lty = 1:3,xlab = 'Date', ylab = 'Price')
legend('right',c('AAPL','GOOG','MSFT'),lty=1:3,cex=0.5)


plot(as.zoo(stocks[,c('AAPL.Close','MSFT.Close')]),screens = 1,lty = 1:2,xlab = 'Date', ylab = 'Price')
par(new=TRUE)
plot(as.zoo(stocks[,c('GOOG.Close')]),screens = 1,lty = 3,xaxt='n',yaxt='n',xlab = 'Date', ylab = 'Price')
par(mfrow=c(1,1))

names(MSFT) <- c('Open','High','Low','Close','Volume','Adj')


cor(stocks)








