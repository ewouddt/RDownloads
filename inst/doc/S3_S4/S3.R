########
## S3 ##
########


## Examples ##

methods("summary")
#   [1] summary.aov                    summary.aovlist*               summary.aspell*                summary.check_packages_in_dir*
#   [5] summary.connection             summary.data.frame             summary.Date                   summary.default               
#   [9] summary.ecdf*                  summary.factor                 summary.glm                    summary.infl*                 
#   [13] summary.lm                     summary.loess*                 summary.manova                 summary.matrix                
#   [17] summary.mlm*                   summary.nls*                   summary.packageStatus*         summary.PDF_Dictionary*       
#   [21] summary.PDF_Stream*            summary.POSIXct                summary.POSIXlt                summary.ppr*                  
#   [25] summary.prcomp*                summary.princomp*              summary.proc_time              summary.srcfile               
#   [29] summary.srcref                 summary.stepfun                summary.stl*                   summary.table                 
#   [33] summary.tukeysmooth* 
methods(class="lm")
# [1] add1           alias          anova          case.names     coerce         confint        cooks.distance deviance      
# [9] dfbeta         dfbetas        drop1          dummy.coef     effects        extractAIC     family         formula       
# [17] hatvalues      influence      initialize     kappa          labels         logLik         model.frame    model.matrix  
# [25] nobs           plot           predict        print          proj           qr             residuals      rstandard     
# [33] rstudent       show           simulate       slotsFromS3    summary        variable.names vcov      



## Make S3 Class ##

CreateLunch <- function(food="sandwhiches",drink="water"){
  
  person <- list(food=food,drink=drink) # Person is a list class
  
  class(person) <- "Lunch"
  # or
  # class(person) <- append(class(person),"Lunch")
  return(person)
}

Nolen <- CreateLunch()
Nolen
# $food
# [1] "sandwhiches"
# 
# $drink
# [1] "water"
# 
# attr(,"class")
# [1] "Lunch"


## Extend existing method ##

summary.Lunch <- function(x){
  cat("This person ate",x$food,"and drank",x$drink)
}

summary(Nolen)
# This person ate sandwhiches and drank water




## Create a new S3 Method ##

# Step 1 - Create a Generic (default)
ChangeLunch <- function(LunchObject,newFood,newDrink,...){
  print("We start at the base Generic")
  UseMethod("ChangeLunch",LunchObject)
  print("This is never executed!")
}


# Step 2 (Optional) - A default execution (For example: if the input is not what you expect it to be)
ChangeLunch.default <- function(LunchObject,newFood,newDrink,...){
  print("What happened? How did I get here?")
  return(LunchObject)
}

# Step 3 - Execute method on your class
ChangeLunch.Lunch <- function(LunchObject,newFood,newDrink){
  print("This person changed his mind what to eat and drink!")
  LunchObject$food <- newFood
  LunchObject$drink <- newDrink
  return(LunchObject)
}


Nolen <- ChangeLunch(Nolen,newFood="cake",newDrink="coffee")
# [1] "We start at the base Generic"
# [1] "This person changed his mind what to eat and drink!"

Nolen
# $food
# [1] "cake"
# 
# $drink
# [1] "coffee"
# 
# attr(,"class")
# [1] "Lunch"
summary(Nolen)
# This person ate cake and drank coffee


test <- 1:10
test <- ChangeLunch(test,newFood="cake",newDrink="coffee")
# [1] "We start at the base Generic"
# [1] "What happened? How did I get here?"
test
# [1]  1  2  3  4  5  6  7  8  9 10


## Inheritance ##
# General Idea: go more specialised
# Here: Toy Example

class(Nolen)
# [1] "Lunch"
class(Nolen) <- append(class(Nolen),"data.frame")
class(Nolen)
# [1] "Lunch"      "data.frame"
summary(Nolen)
# This person ate cake and drank coffee
class(Nolen) <- c("data.frame","Lunch")
summary(Nolen)
# food              drink          
# Length:1           Length:1          
# Class :character   Class :character  
# Mode  :character   Mode  :character  



## No Validation ##
Ewoud <- "I am just a string in disguise"
class(Ewoud) <- "Lunch"
summary(Ewoud)
# Error in x$food : $ operator is invalid for atomic vectors 



