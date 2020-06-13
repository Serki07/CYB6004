#/bin/bash

#ask users to enter password

Red="\033[31m"

Reset="\033[0m"

Green="\033[32m"

read -sp "$(echo -e $Red"Please enter password: "$Reset)" password

echo

#pass saved hashed password to paramenter 

savedpass='secret.txt'

#compair enterd password with saved hash password

if echo "$password" | sha256sum -c --status  "$savedpass" ; then

#if correct Grant Access

echo -e "${Green}Access Granted${Reset}"

    exit 0

    else

    #otherwise, print error

        echo -e "${Red}Access Denied${Reset}"

            exit 1

fi













            