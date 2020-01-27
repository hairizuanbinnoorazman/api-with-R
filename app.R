# plumber.R
library(base64enc)

source("script.R")

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function(){
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b){
  as.numeric(a) + as.numeric(b)
}

#* Run analysis
#* @param message The data that is to be provided
#* @post /
function(message) {
  print(message["data"])
  print(rawToChar(base64decode(message$data)))
  doAnalysis()
}

