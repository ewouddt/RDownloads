########
## S4 ##
########

## Examples ##


library(Biobase)
showClass("ExpressionSet")
# Class "ExpressionSet" [package "Biobase"]
# 
# Slots:
#   
#   Name:      experimentData          assayData          phenoData        featureData         annotation       protocolData
# Class:              MIAME          AssayData AnnotatedDataFrame AnnotatedDataFrame          character AnnotatedDataFrame
# 
# Name:   .__classVersion__
# Class:           Versions
# 
# Extends: 
#   Class "eSet", directly
# Class "VersionedBiobase", by class "eSet", distance 2
# Class "Versioned", by class "eSet", distance 3



## Make S4 Class ##


FoodOrderClass <- setClass(
  # Set the name for the class
  Class="FoodOrder",
  
  # Define the slots
  slots = c(
    food = "character",
    number = "numeric"
  ),
  
  # Set the default values for the slots. (optional)
  prototype=list(
    food = "sandwich",
    number = 10
  ),
  
  # Make a function that can test to see if the data is consistent.
  # This is not called if you have an initialize function defined!
  validity=function(object)
  {
    food_available <- c("sandwich","salad","salmon","mozarella","tomato")
    
    if(!all(object@food %in% food_available)){
      return("Not all ordered food is available!")
    }
    
    if(length(object@food)!=length(object@number)){
      return("Not all food items have an associated number!")
    }
    
    return(TRUE)
  }
)

# Define it with the function
Nolen <- FoodOrderClass(food=c("sandwich","salmon"),number=c(10,25))
Nolen
# An object of class "FoodOrder"
# Slot "food":
#   [1] "sandwich" "salmon"  
# 
# Slot "number":
#   [1] 10 25
Nolen@food
# [1] "sandwich" "salmon" 

# Or define it with new() function
Ewoud <- new("FoodOrder",food=c("sandwich","mozarella","tomato"),number=c(10,15,5))
Ewoud
# An object of class "FoodOrder"
# Slot "food":
#   [1] "sandwich"  "mozarella" "tomato"   
# 
# Slot "number":
#   [1] 10 15  5


# Validity Checking:
test <- FoodOrderClass(food=c(1,2,3),number=c(1,2,3))
# Error in validObject(.Object) : 
#   invalid class “FoodOrder” object: invalid object for slot "food" in class "FoodOrder": 
#   got class "numeric", should be or extend class "character"
test <- FoodOrderClass(food=c("sandwich","beer"),number=c(1,2))
# Error in validObject(.Object) : 
#   invalid class “FoodOrder” object: Not all ordered food is available!


## Make S4 Method ##


# Make the generic (This is skipped if you extend existing method, e.g. pData() ) 
setGeneric(name="ComputePrice",
           def=function(OrderObject,discount=0)
           {
             standardGeneric("ComputePrice")
           }
)

# Set a method for the new generic
setMethod(f="ComputePrice",
          signature=c("FoodOrder","numeric"),
          
          definition=function(OrderObject,discount=0)
          {
            
            food_prices <- c(sandwich=1.75,salad=1.25,salmon=2.25,mozarella=1.5,tomato=0.75)
            price <- 0
            for(i in 1:length(OrderObject@food)){
              price <- price +  food_prices[OrderObject@food[i]]*OrderObject@number[i]
            }
            price <- round((1-discount)*price,2)
            names(price) <- NULL
            
            cat("Total Price of Food Order:",price,"euro")
            return(price)
          }
)


price <- ComputePrice(Nolen,discount=0.1)
# Total Price of Food Order: 66.38 euro
price
# [1] 66.38

price <- ComputePrice(Ewoud,discount=0)
# Total Price of Food Order: 43.75 euro
price
# [1] 43.75


