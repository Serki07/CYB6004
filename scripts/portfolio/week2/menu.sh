#!/bin/bash

./passwordCheck.sh
if [ $? -eq 0 ]; then
    echo "Select an option " 
    echo "1. Create a folder"
    echo "2. Copy a folder "
    echo "3. Set a password "    
    correct=true  
    
else   
echo " Goodbye"
correct=false
exit
fi
read -p "Please enter the option: " option 
case $correct in
false)
echo "Thanks Bye"
;;
true)

    if [ $option -eq 1 ]; then
    ./foldermaker.sh
    elif [ $option -eq 2 ] ; then
    ./foldercopier.sh
    elif [ $option -eq 3 ] ; then
    ./setPassword.sh
    else 
    echo " please enter correct number "
    fi
;;

esac
      
    
    
    
   