

## Internal function which plots the results using ggplot2 ##

plot_cranlogs <- function(x,by="month",name="Package",from="01-01-2016",to="02-02-2016"){
  
  if(by=="month"){
    months_temp <- months(x$date)
    years <- format(x$date,"%Y")
    months <- paste0(months_temp,years)
    
    unique_months <- unique(months)
    
    month_count <- 1:length(unique_months)
    for(i in 1:length(unique_months)){
      month_count[i] <- sum(x$count[which(months==unique_months[i])])
    }
    
    x_month <- data.frame(month = unique_months , count = month_count)
    x_month$month <- factor(unique_months,levels=unique(unique_months))
    
    graph <- ggplot(data=x_month,aes(x=month,y=count,group=1)) + geom_line()+ geom_point()+
      theme(plot.caption=element_text(margin=margin(t=15),face="italic", size=8),axis.text.x = element_text(angle = 90, hjust = 1),plot.title=element_text(face="bold"),plot.subtitle=element_text(margin=margin(b=15)))  + 
      labs(caption=paste0("From ",from," to ",to),title=paste0("Downloads of ",name),subtitle=paste0("Total Number of Downloads = ",sum(x$count)),x="Month & Year",y="Number of Downloads per Month")
  }
  if(by=="day"){
    months_temp <- months(x$date)
    years <- format(x$date,"%Y")
    month <- paste0(months_temp,years)
    
    x$month <- factor(month,levels=unique(month))
    x$date <- factor(as.character(x$date),levels=unique(as.character(x$date)))
    
    graph <- ggplot(data=x,aes(x=date,y=count,group=1,color=month)) + 
      geom_line()+ geom_point()+ scale_color_discrete(name="Month & Year")+
      theme(plot.caption=element_text(margin=margin(t=15),face="italic", size=8),axis.text.x = element_text(angle = 90, hjust = 1),plot.title=element_text(face="bold"),plot.subtitle=element_text(margin=margin(b=15)))  + 
      labs(caption=paste0("From ",from," to ",to),title=paste0("Downloads of ",name),subtitle=paste0("Total Number of Downloads = ",sum(x$count)),x="Date",y="Number of Downloads per Day")
    
  }
  
  return(graph)
}


if(getRversion() >= "2.15.1"){
  globalVariables(c("count"))
}
