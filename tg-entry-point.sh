#!/bin/sh

EXTERNAL_IP=$(curl -4 -s https://ifconfig.co)
INTERNAL_IP="$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')"

echo "External IP: $EXTERNAL_IP"
echo "Internal IP: $INTERNAL_IP"
./mtproto-proxy -u nobody -p 8888 -H 443 -S $1 --aes-pwd proxy-secret proxy-multi.conf -M 1 --nat-info "$INTERNAL_IP:$EXTERNAL_IP"
