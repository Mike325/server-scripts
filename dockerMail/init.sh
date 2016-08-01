#!/bin/bash

PASSWORD="nada"
CHECK="vacio"

echo ""
echo "------> Enter your domail ex. example.com" 
read DOMAIN 

echo ""
echo "------> Enter your new mailbox address (without the domain), ex. new.address"
read MAIL 

MAIL="$MAIL@$DOMAIN"

while [[ "$PASSWORD" != "$CHECK" ]]; do
    echo ""
    echo "------> Enter the password" 
    read -s PASSWORD

    echo "------> Confirm your password" 
    read -s CHECK 
    if  [[ "$PASSWORD" != "$CHECK" ]]; then
        echo ""
        echo "------> Please enter the same password on each phase" 
    fi
done

mkdir -p config

docker pull tvial/docker-mailserver:latest
docker run --rm \
    -e MAIL_USER=$MAIL\
    -e MAIL_PASS="$PASSWORD"\
    -ti tvial/docker-mailserver:latest \
    /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> config/postfix-accounts.cf

docker run --rm \
    -v "$(pwd)/config":/tmp/docker-mailserver \
    -ti tvial/docker-mailserver:latest generate-dkim-config

cp config/opedkim/keys/domain.tld/mail.txt .

cp mail.service /etc/systemd/system
systemctl daemon-reload
systemctl enable mail.service

#./certbot-auto --email $MAIL --agree-tos   
echo ""
echo "------> Please enter your machine's host ex. mail.$DOMAIN" 
read HOST 
./certbot-auto certonly --standalone --email $MAIL -d $DOMAIN --agree-tos 

docker-compose up -d mail
