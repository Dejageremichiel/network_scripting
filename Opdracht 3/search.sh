#!/bin/bash

# 14 days in seconds 
DAYS="1209600" 

_openssl="/usr/bin/openssl"

find / -type f -name "server.crt" | while read line
do 
    $_openssl x509 -enddate -noout -in "$line"  -checkend "$DAYS" | grep -q 'Certificate will expire'

    if [ $? -eq 0 ]
    then
        echo -e "\e[31mThis certificate will expire in 14 days or is already expired\e[0m"
        echo "$line"
    fi
done 




