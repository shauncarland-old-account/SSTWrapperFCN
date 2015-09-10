get_sst_data <- function(lat1,lat2,lon1,lon2,month1,month2,year1,year2){
  #browser()
  #check the data
  if (!is.numeric(lat1)){
    stop("Lat1 must be an integer")
  }
  if (!is.numeric(lat2)){
    stop("Lat2 must be an integer")
  }
  if (!is.numeric(lon1)){
    stop("Lon1 must be an integer")
  }
  if (!is.numeric(lon2)){
    stop("Lon2 must be an integer")
  }
  if (!is.numeric(month1)){
    stop("Month1 must be an integer")
  }
  if (!is.numeric(month2)){
    stop("Month2 must be an integer")
  }
  if (!is.numeric(year1)){
    stop("Year1 must be an integer")
  }
  if (!is.numeric(year2)){
    stop("Year2 must be an integer")
  }
  
  #convert the months into days passed since 1800-1-1 
  start_date <- as.Date("1-1-1800",format="%d-%m-%Y")
  date1 <- as.Date(paste("1 ",month1,year1,sep=" "),format = "%d %m %Y")
  date2 <- as.Date(paste("1 ",month2,year2,sep=" "),format = "%d %m %Y")
  
  time1 <- as.numeric(difftime(date1,start_date))
  time2 <- as.numeric(difftime(date2,start_date))
  
  #todo: 
  #ensure year1 <= year2
  #make it variable on which tables to pull from (not just year1800)
  
  SQL <-  paste("SELECT * FROM year1800 WHERE LAT >= ",lat1," AND LAT <= ",lat2, " AND LON >= ",
                lon1," AND LON <= ",lon2, " AND TIME >= ", time1, " AND TIME <= ",time2, ";", sep ="")
  #browser()
  #connect to the data base
  con <- dbConnect(dbDriver("MySQL"),
                   user = user,
                   pass = pass,
                   host = host,
                   dbname = dbname
  )
  #run the query
  results <- dbGetQuery(con,SQL)
  return(results)
}


#examples: 
get_sst_data(20,80,100,132,1,1,1854,1854)