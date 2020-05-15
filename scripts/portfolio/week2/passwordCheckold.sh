#!/bin/bash
#ask users to enter password
read -sp "Please enter password: " password
# pass enterd password to text file 
echo $password >pass.txt
#add new line
echo
#Check if enterd password is correct by compairing it with saved hasd password 
if echo "f33ae3bc9a22cd7564990a794789954409977013966fb1a8f43c35776b833a95  pass.txt"|  sha256sum -c --status ; then
    #Grant access
    echo "Access Granted"
    exit 0
else
    #otherwise, print error
    echo "Access Denied"
    exit 1
fi

echo $secret
echo $password |sha256sum

if [ echo "$password" |sha256sum --check secret.txt ];then
echo "yay!!"
exit 0

else
echo "sorry"

fi