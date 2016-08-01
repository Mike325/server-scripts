#!/bin/bash

OVPN_DATA="ovpn-data"
URL="HOST.domain.tld"

echo ""
echo "------> Enter your host and domain name ex. $URL"
read URL 

docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://$URL
docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki
docker run --name openVPN --volumes-from $OVPN_DATA -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

cp vpn.service /etc/systemd/system
systemctl daemon-reload
systemctl enable vpn.service
