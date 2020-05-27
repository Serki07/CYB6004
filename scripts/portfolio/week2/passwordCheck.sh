#/bin/bash
#ask users to enter password
read -sp "Please enter password: " password

echo
#pass saved hashed password to paramenter 
savedpass='secret.txt'
#compair enterd password with saved hash password
if echo "$password" | sha256sum -c --status  "$savedpass" ; then
# Grant Access
echo -e "Access Granted"
    exit 0
else
#otherwise, print error
    echo -e "Access Denied"
    exit 1
fi






