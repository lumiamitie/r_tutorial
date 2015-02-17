p <- plotly(username='R-Demo-Account', key='yu680v5eii')

data <- list(
  list(
    x = c("giraffes", "orangutans", "monkeys"), 
    y = c(20, 14, 23), 
    type = "bar"
  )
)

response <- p$plotly(data, kwargs=list(filename="basic-bar", fileopt="overwrite"))
url <- response$url
filename <- response$filename
#########################################3
set_credentials_file(username="lumin27", api_key="rc60j1hu6k")



library(plotly)

dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
d <- qplot(carat, price, data=dsamp, colour=clarity)
py=plotly()
py$ggplotly()
