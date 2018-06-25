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
docker run --name=shadowsocks$SS_PORT --restart=always -p $SS_PORT:$SS_PORT -d tommylau/shadowsocks -s 0.0.0.0 -p $SS_PORT -k $SS_PASSWORD -m aes-256-ctr

# Telegram MTProto
docker run -d --name=tg1 -p$TG_PORT:$TG_PORT -v proxy-config:/data -e SECRET=$TG_SECRET telegrammessenger/proxy:latest

# Brook
docker build -t brook -f Brook-Dockerfile .
docker run -d -e "BROOK_PASSWORD=$BROOK_PASSWORD" -p $BROOK_PORT:9999/tcp -p $BROOK_PORT:9999/udp --restart always --name brook1 brook
