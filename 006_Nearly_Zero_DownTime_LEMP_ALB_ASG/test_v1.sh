#!/bin/sh
#
# Update
#
yum makecache
yum update -y
#
# NGINX
#
yum install yum-utils -y
touch /etc/yum.repos.d/nginx.repo
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/amzn2/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/amzn2/\$releasever/\$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF

yum-config-manager --enable nginx-stable
yum makecache
yum install nginx -y
systemctl start nginx; sudo systemctl enable nginx
sleep 5s
echo "<h1>Version 1</h1>" > /usr/share/nginx/html/index.html

# Health Checks
echo "<h1>check</h1>" > /usr/share/nginx/html/check.html
