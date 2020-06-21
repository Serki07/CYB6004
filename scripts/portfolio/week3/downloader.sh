#!/bin/bash

while true
do
    #option to download or exit
    read -p "Please enter url to download or exit to quit:" 

    case $REPLY in

        exit)
            #exit if input exit
            echo "Goodbye!"
            exit 1
            ;;
        *)
            # download and save in provided location
            echo
            read -p "Please enter the loction you want to save:" location
            echo $location
            wget -P $location $REPLY 
            ;;
    esac 

done