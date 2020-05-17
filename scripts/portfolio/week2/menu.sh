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

    case $option in
    1)
     ./foldermaker.sh
     ;;
    2)
    ./foldercopier.sh
    ;;
    3)
     ./setPassword.sh
    ;;
     *)
    echo " please enter correct number "
    ;;
    esac
    
    
   
;;

esac
      
    
    
    
   