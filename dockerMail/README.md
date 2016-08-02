# Docker Mail Server

This scripst uses [docker-mailserver](https://github.com/tomav/docker-mailserver) repo to create a minimal POSTFIX mail server.


## Permissions

First you need to clone this repo and chenge the user permition to run the scripts.

```
cd ~/
git clone https://github.com/Mike325/server-scripts.git
cd server-scripts/dockerMail
sudo chmod +x init.sh newMailbox.sh

```
The **init.sh** must be run with sudo command or as root because it adds a systemd entry to start the mail container on boot.
The **newMailbox.sh** can be run as normal user, but it most be run under the volume dir that contains the data and configurations of the mail server, usually this directory is the one where you first run the *init.sh* script.

## Start the server

* First you need to move the git folder to where you want to keep your data (you inbox mails and your configurations) ex. *~/mailbox* or */home/mailserver*, feel free to rename the git folder.

```
cd ~/server-scripts
cp -R dockerMail/ ~/ && cd ~/
mv dockerMail/ mailbox/
```

* Edit the file **docker-compose.yml** and fill the *hostname* and *domainname* 
* Then you must run the **init.sh** script as sudo or root and complete the require data.

```
sudo ./init.sh
```
* After the initial setup you must setup your DNS with the txt file that was moved to the root of your data dir
* Any time you want a new mail account you can run the **newMailbox.sh** script

