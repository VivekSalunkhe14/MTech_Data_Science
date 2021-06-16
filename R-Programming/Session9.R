library(openxlsx)
setwd("D:/R")

#normal file
write.xlsx(iris, file="writexlsx1.xlsx")
#tabulated file with filters for each column
write.xlsx(iris, file="writexlsxtable.xlsx", asTable = TRUE)


l <- list("IRIS"=iris,"MTCARS"=mtcars)
write.xlsx(l, file = "writelist.xlsx")
write.xlsx(l, file = "writelisttable.xlsx", asTable = TRUE)

options("openxlsx.borderColour" = "#4F80BD")
options("openxlsx.borderStyle" = "thick")
options("openxlsx.dateFormat" = "mm/dd/yyyy")
options("openxlsx.datetimeFormat" = "yyyy-mm-dd hh:mm:ss")
options("openxlsx.numFmt" = NULL)

df <- data.frame("Date" = Sys.Date()-0:19, "LogicalT" = TRUE,
                 "Time"= Sys.time()-0:19*60*60,
                 "Cash" = paste("$",1:20),"Cash2"=31:50,
                 "hlink" = "https://google.com/",
                 "Percentage" = seq(0, 1, length.out=20),
                 "TinyNumbers" = runif(20) / 1E9, stringsAsFactors = FALSE)

class(df$Cash) <- "currency"
class(df$Cash2) <- "accounting"
class(df$hlink) <- "hyperlink"
class(df$Percentage) <- "percentage"
class(df$TinyNumbers) <- "scientific"


write.xlsx(df, "writexlsx3.xlsx")
#

hs <- createStyle(fontColour = "#ffffff", fgFill = "#e3426a", halign = "center", valign="center",
                  textDecoration = "Bold", border = "TopBottomLeftRight", textRotation = 45)

write.xlsx(iris, file="writexlsx4.xlsx", borders="rows", headerStyle=hs)
write.xlsx(iris, file="writexlsx5.xlsx", borders="columns", headerStyle=hs)

l <- list("IRIS" = iris, "colClasses" = df)
#


wb <- write.xlsx(iris, "writexlsx6.xlsx")
setColWidths(wb, sheet = 1, cols = 1:5, widths = 20)
#setRowHeights(wb, sheet = 1, rows = 1:10, heights = 10)
saveWorkbook(wb, "writexlsx6.xlsx", overwrite = TRUE)
openXL("writexlsx6.xlsx")


library(ggplot2)
wb <- createWorkbook()
options("openxlsx.borderColour" = "#4F80BD")
options("openxlsx.borderStyle" = "thin")
modifyBaseFont(wb, fontSize = 10, fontName = "Arial Narrow")

addWorksheet(wb, sheetName = "Motor Trend Car",gridLines = FALSE)
addWorksheet(wb, sheetName = "Iris",gridLines = FALSE)

freezePane(wb, sheet = 1,firstRow = TRUE, firstCol = TRUE)

writeDataTable(wb, sheet = 1, x = mtcars, colNames = TRUE, rowNames = TRUE, tableStyle = "TableStyleLight9")

setColWidths(wb,sheet = 1, cols = "A", widths = 18)

writeDataTable(wb, sheet = 2, x = iris, startCol = "K", startRow = 2)

qplot(data = iris, x = Sepal.Length, y = Sepal.Width, colour = Species)
insertPlot(wb,2,xy=c("B",16))

means <- aggregate(x = iris[,-5], by = list(iris$Species), FUN = mean)
vars <- aggregate(x = iris[,-5], by = list(iris$Species), FUN = var)


headSty <- createStyle(fgFill = "#DCE6F1", halign = "center", border = "TopBottomLeftRight")
writeData(wb,2,x = "Iris dataset group means", startCol = 2,startRow = 2)
writeData(wb,2,x = means, startCol = "B",startRow = 3, borders = "rows", headerStyle = headSty)

writeData(wb,2,x = "Iris dataset group vaiances", startCol = 2,startRow = 2)
writeData(wb,2,x = vars, startCol = "B",startRow = 10, borders = "columns", headerStyle = headSty)


setColWidths(wb, 2, cols = 2:6, widths = 12)
setColWidths(wb, 2, cols = 11:15, widths = 15)

s1 <- createStyle(fontSize = 14,textDecoration = c("bold","italic"))
addStyle(wb,2,style = s1, rows=c(2,9),cols = c(2,2))

saveWorkbook(wb,"file1.xlsx", overwrite =TRUE)




ticker <- "TCS.NS"
csv.url <- paste0("https://query1.finance.yahoo.com/v7/finance/download/",ticker,"?period1=1574310779&period2=1605933179&interval=1d&events=history&includeAdjustedClose=true")

prices <- read.csv(url(csv.url),as.is = TRUE)
prices$Date <- as.Date(prices$Date)
close <- prices$Close
prices$logReturns = c(0, log(close[2:length(close)]/close[1:(length(close)-1)]))


ggplot(data = prices, aes(as.Date(Date), as.numeric(close))) + 
  geom_line(colour = "royalblue2") + 
  labs(x="Date", y="Prices", title = ticker) + 
  geom_area(fill = "royalblue2", alpha = 0.3) + 
  coord_cartesian(ylim = c(min(prices$Close)-1.5,max(prices$Close)+1.5))

addWorksheet(wb, sheetName = "TCS")
insertPlot(wb, sheet = 1,xy = c("J",3))

ggplot(data=prices,aes(x = logReturns)) + geom_histogram(binwidth = 0.0025) + 
  labs(title = "Histogram of Log Returns")

class(prices$Close) <- "currency"

writeDataTable(wb, sheet = "TCS", x = prices)
insertPlot(wb, sheet = 1, startRow = 25, startCol = "J")

conditionalFormatting(wb, sheet = 1,cols=1:ncol(prices), rows = 2:(nrow(prices)+1),
                      rule = "$H2>0.01")


install.packages("plotly")
library(plotly)
library(tidyverse)
