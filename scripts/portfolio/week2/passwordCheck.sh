#/bin/bash
#ask users to enter password
read -sp "Please enter password: " password
echo
# hash the enterd password and pass it to text file 


echo $password|sha256sum >pass.txt

#call stored password
secret="$(<secret.txt)"
#call enterd password 
pass="$(<pass.txt)"
#check if enterd password is correct 


if [ "$secret" == "$pass" ];then
#grant access 
    echo "Access Granted"
    exit 0
else
#otherwise, print error
    echo "Access Denied"
    exit 1
fi





