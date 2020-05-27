#!/bin/bash
#ask users to Enter Folder Name 
read -p "Please enter folder name/path : " Foldername
#ask users to enter password 
read -sp "Please enter Password: " password
#start new line 
echo
#take input from user, hash it using sha256sum and save it to secret.txt
echo $password |sha256sum >secret.txt
#move secret.txt to location where users enterd
mv secret.txt ./$Foldername

