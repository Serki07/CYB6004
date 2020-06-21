#!/bin/bash

Blue="\033[34m"
Green="\033[32m"
Red="\033[31m"
Purple="\033[35m"
Reset="\033[0m"
#show the artimetic menu
echo " Please choose the arithmetic you want to perform"
echo " 1 for Addition"
echo " 2 for Subtraction"
echo " 3 for Multiplication"
echo " 4 for Division"
#Accept menu input
read -p "Arthmetic:" arithmetic 
echo
#check if enterd value is valid
if (($arithmetic>=1 && $arithmetic <=4 )) ; then
    #accept the first number
    read -p "Please enter the first number to calculate: " num1
    echo
    #accept the second number
    read -p "Please enter the second number to calculate: " num2
    echo
    #check if input is only numbers
    re='^[0-9]+$'
    if ! [[ $num1 =~ $re ]] || ! [[ $num2 =~ $re ]] ; then
        #if not numbers print error and exit
        echo "Error Not a number! Please enter number/s" ; exit 1
        fi
else 
    echo "Please enter the correct number"
    exit  
fi

# case statment to check arithmetic condition

case $arithmetic  in
 
     #if menu1 is selected, perform addtion   
    1) 
        result=$((num1 + num2)) 
        echo -e  "${Blue}$num1 + $num2: $result${Reset}"
        ;;
    
    2) #if menu2 is selectd perform subtraction
        result=$((num1 - num2))
        echo -e "${Green}$num1 - $num2: $result${Reset}"
        ;;
    3) # if meun3 is selected perform multiplication
        result=$((num1 * num2))
        echo -e "${Red} $num1 * $num2: $result${Reset}"
        ;;
    4) # menu4 is selected perform dividion
        result=$((num1 / num2))
        echo  -e  "${Purple} $num1 / $num2: $result${Reset}"
        ;;
    *) 
        #otherwise, print error
        echo "Please enter the correct value"
        ;;
esac

