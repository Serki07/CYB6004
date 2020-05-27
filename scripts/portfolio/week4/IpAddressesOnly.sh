#!/bin/bash
#call IpInfo script and assign to varable
IpOutput="$(./IpInfo.sh)"

#read the variable from above and print only specified 
echo "$IpOutput"| sed -n '/IP Address/p' 


