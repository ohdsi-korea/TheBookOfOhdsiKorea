stringOfInterest<-"관찰형"

rmdFiles<-list.files()[grepl(".Rmd",list.files())]

#identify where the string of interest exists.
for (singleRmd in rmdFiles){
  #print(singleRmd)
  if(length(grep(stringOfInterest, readLines(singleRmd), value = TRUE))){
    print(singleRmd)
    grep(stringOfInterest, readLines(singleRmd), value = TRUE)
  }
}

