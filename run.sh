#!/bin/bash

# Configurations
if [ ! -f configs.sh ]; then
    echo "configs.sh file not found"
    exit 1
fi

source configs.sh

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y docker-ce

# Shadowsocks
docker run --name=ss1 --restart always -p $SS_PORT:$SS_PORT -d tommylau/shadowsocks -s 0.0.0.0 -p $SS_PORT -k $SS_PASSWORD -m aes-256-ctr

# Telegram MTProto
docker build -t mtproto-proxy -f Telegram-Dockerfile .
docker run -d -p $TG_PORT:443 -e TG_SECRET=$TG_SECRET --restart always --name tg1 mtproto-proxy

# Brook
docker build -t brook -f Brook-Dockerfile .
docker run -d -e "BROOK_PASSWORD=$BROOK_PASSWORD" -p $BROOK_PORT:9999/tcp -p $BROOK_PORT:9999/udp --restart always --name brook1 brook
