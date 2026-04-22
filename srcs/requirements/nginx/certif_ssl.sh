#!/bin/sh

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/ifounas.key \
  -out /etc/nginx/ssl/ifounas.crt \
  -subj "/CN=ifounas.42.fr"