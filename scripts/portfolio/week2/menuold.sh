#!/bin/bash

./passwordCheck.sh
if [ $? -eq 0 ]; then
    echo "Select an option " 
    echo "1. Create a folder"
    echo "2. Copy a folder "
    echo "3. Set a password "    
    read -p "" option   
    if [ $option -eq 1 ]; then
    ./foldermaker.sh
    elif [ $option -eq 2 ] ; then
    ./foldercopier.sh
    elif [ $option -eq 3 ] ; then
    ./setPassword.sh
    else 
    echo " please enter correct number "
    fi
else   
echo " Goodbye"
fi


