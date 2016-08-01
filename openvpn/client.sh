#!/bin/bash

OVPN_DATA="ovpn-data"

echo ""
echo "------> Enter your new device's name ex. smartphone"
read CLIENT

docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full "$CLIENT" nopass
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient "$CLIENT" > "$CLIENT".ovpn
