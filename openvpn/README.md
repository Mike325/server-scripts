# OpenVPN setup scripts

This scripts rely on kylemanna's [OpenVPN Docker](https://github.com/kylemanna/docker-openvpn) image, please refere to main repo for more in deep instructions.

## Setup VPN

After you have cloned this repo, you must chenge the user permition to run the scripts.

```
cd server-scripts/openvpn
sudo chmod +x init.sh client.sh
```

Then you just need yo run the **init.sh** script to start the container and the **client.sh** to create new certificates.

```
sudo ./init.sh
./client.sh
```

- The **init.sh** must be run with sudo command or as root because it adds a systemd entry to start the vpn container on boot.
- The **client.sh** can be run as normal user, this script will generate the cliente.ovpn file that must be imported on each client app.
