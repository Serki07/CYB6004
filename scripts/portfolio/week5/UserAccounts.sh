#!/bin/bash
echo "User Accounts:"
awk 'BEGIN { 
    # check Field Separator 
    FS=":"; 
    #Print the top table boarder
    print " _______________________________________________________________________________________________";
    #print the header
    print "| \033[34mUsername\033[0m            | \033[34mUser ID\033[0m   |\033[34mGroup ID\033[0m    |\033[34mHome\033[0m                      |\033[34mShell\033[0m                |";
    print "|_____________________|___________|____________|__________________________|_____________________|";
 #Print the border
}
{
    #filter column with if condition
    if ($7 ~ /^(\/[b][i][n]\/[b][a][s][h])$/)
    #print the output with desire color
    printf("| \033[33m%-20s\033[0m| \033[35m%-10s\033[0m|  \033[35m%-10s\033[0m| \033[35m%-25s\033[0m| \033[35m%-20s\033[0m|\n", $1, $3, $4, $6,$7 );
}

END {
    #print the bottom table boarder
    print("|_____________________|___________|____________|__________________________|_____________________|");
}' /etc/passwd