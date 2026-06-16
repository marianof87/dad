#!/bin/bash
# Launch MariaDB container with Podman
podman run -d --name mariadb -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=password \
    -e MYSQL_DATABASE=docker_sample \
    -v "$(pwd)/../mariadb/data:/var/lib/mysql" \
    mariadb:10.5

# Ensure it's started
podman start mariadb