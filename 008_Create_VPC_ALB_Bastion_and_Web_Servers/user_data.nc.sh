#!/bin/sh
export PRIVATE_IP=`curl 169.254.169.254/latest/meta-data/local-ipv4`

touch /home/ubuntu/index.html

cat << EOF > /home/ubuntu/index.html
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Server: netcat!

<!doctype html>
<html><body><h1>NC Server on $PRIVATE_IP</h1></body></html>
EOF

while true; do cat /home/ubuntu/index.html | nc -l 80; done
