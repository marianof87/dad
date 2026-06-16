#!/bin/bash
# Launch Nginx container with Podman
podman run -itd --name nginx \
    --network lemp-network \
    -v "$(pwd)/../config/nginx":/etc/nginx/conf.d \
    -v "$(pwd)/../code/myapp":/var/www/html/myapp \
    -v "$(pwd)/../logs":/var/log/nginx \
    -p 8080:80 \
    nginxphp7