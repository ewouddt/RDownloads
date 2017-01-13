library(MyFirstPackage)

tidyverse <- c("ggplot2","tibble","tidyr","dplyr")

TidyVerse_gplots <- vector("list",length(tidyverse))


for(i in 1:length(tidyverse)){
  TidyVerse_gplots[[i]] <- plotDownloads(tidyverse[i],from="2014-01-01",to="2016-11-30") 
}

TidyVerse_gplots[[1]]
TidyVerse_gplots[[2]]
TidyVerse_gplots[[3]]
TidyVerse_gplots[[4]]


