#!/bin/bash

PASSWORD="n"
CHECK="e"
let OPTION=1
MAIL="n"

function newMailbox() 
{
    echo ""
    echo "------> Please enter your new mailbox ex. new.mailbox@domain.tld"
    read MAIL 

    while [[ "$PASSWORD" != "$CHECK" ]]; do
        echo ""
        echo "------> Enter the password" 
        read PASSWORD

        echo "------> Confirm your password" 
        read CHECK 
        if  [[ "$PASSWORD" != "$CHECK" ]]; then
            echo ""
            echo "------> Please enter the same password on each phase" 
        fi
    done

    mkdir -p config
    docker run --rm \
        -e MAIL_USER=$MAIL\
        -e MAIL_PASS="$PASSWORD"\
        -ti tvial/docker-mailserver:latest \
        /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> config/postfix-accounts.cf

    docker stop mail
    docker rm mail
    docker-compose up -d mail
}

while [[ $OPTION -ne 2 ]]; do
    echo ""
    echo "------> Select your option"
    echo "-------------> 1) New mailbox"
    echo "-------------> 2) Exit"
    read OPTION 

    case "$OPTION" in
        1)  newMailbox 
            ;;
        2)  echo "Bye"
            ;;
        *)  echo "Error 404 option not found"
            ;;
    esac
done
