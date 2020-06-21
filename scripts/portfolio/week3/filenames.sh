#!/bin/bash
file=$1
#read each line incuding the last line
while read line || [[ -n $line ]];
do
  
  #check if the line is a file
  if test -f "$line"; then
    echo "$line That file exists"
  #check if the line is directory
  elif [ -d "$line" ]; then
    echo "$line is a directory"
  #otherwise print not known 
  else
    echo "$line I don’t know what that is!"
  fi
done < $file