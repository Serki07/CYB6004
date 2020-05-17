#!/bin/bash
 secret='shhh' #Don't tell anyone!
read -s -p "what's the secret code?" REPLY
 echo
 #if the user types in the correct secret, tell them they got it right!
 if [ "$secret" = $REPLY ] ; then
     echo "You got it right!"
    correct=true
else 
 
    echo "You got it wrong :("
    correct=false
 fi
 
 
 case $correct in

    true)
        echo "you have unlocked the secret menu!"
 
    echo
    #promet for menu selection
    echo " Select from the follwoing menu "
    echo "Select 1 for menu 1"
    echo "Select 2 for menu 2"
    echo "Select 3 for menu 3"
    echo
    read -p "Please select menu: " menu
        #case statment to check the menu selection
        case $menu in
        1)
        #output for menu 1
        echo " Thanks! Here is menu 1"
        ;;
        2)
        #output for menu 2
        echo " Thanks! Here is menu 2"
        ;;
        3)
        #output for menu 3
        echo " Thanks! Here is menu 3"
        ;;
        *)
        #output for wrong menu selection
        echo " Wrong Menu! please enter correct menu"
        ;;
        esac
    ;;

    *)
    echo "Go Away!" #people who get it wrong need to be told to go away!
    ;;
 
 esac