## What is it?
This script will install docker and creates the following docker containers:

1. Shadowsocks server
2. Brook server
3. Telegram MTProto Proxy 


## Installation
On your server, clone this repository:

    git clone https://github.com/smbl64/vps-bootstrap
    cd vps-bootstrap
     
Create the config file with your ports and passwords/secrets:

    cp configs.sh.sample configs.sh
    vim configs.sh

Run `sudo run.sh` file.
