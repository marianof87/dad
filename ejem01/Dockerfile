# Imagen actualizada a PHP 8.2 con Apache
FROM php:8.2-apache

# Actualizar repositorios e instalar editores y utilidades
RUN apt-get update && apt-get install -y \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# copiamos todos los ficheros en el directorio en cuestion
COPY src/ /var/www/html

# Exponemos el puerto 80
EXPOSE 80

# Metadata del mantenedor (MAINTAINER está obsoleto)
LABEL maintainer="JL Gonzalez <jlgs@cifpvirgendegracia.com>"