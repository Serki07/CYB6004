#!/bin/bash
#authenticate user
./passwordCheck.sh
#if password is correct show menu
if [ $? -eq 0 ]; then
    echo "Select an option " 
    echo "1. Create a folder"
    echo "2. Copy a folder "
    echo "3. Set a password "    
    correct=true  
#otherwise, print error    
else   
    echo " Goodbye"
    correct=false
    exit
fi
#accept menu choice from user
read -p "Please enter the option: " option 

#check the value of correct
case $correct in
#if false print 
false)
    echo "Thanks Bye"
    ;;
#if true check options
true)

    case $option in
        #if option 1 run folder maker
        1)
            ./foldermaker.sh
            ;;
        #if option 2 run folder copier
        2)
            ./foldercopier.sh
            ;;
        #if option 3 run password set
        3)
            ./setPassword.sh
            ;;
        #for all other, print error
        *)
            echo " please enter correct number "
            ;;
    esac
    
    
   
    ;;

esac
      
    
    
    
   