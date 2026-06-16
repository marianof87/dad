#!/bin/bash
# ============================================
# ejem02 - WordPress + MariaDB con --link
# ============================================
# Crea un contenedor de base de datos MariaDB y
# lo enlaza a un contenedor de WordPress usando
# el mecanismo --link (legacy)
# ============================================

# Crear directorio para WordPress (bind mount local)
echo "📁 Creando directorio wordpress/"
mkdir -p wordpress

echo "🐳 Creando contenedor de base de datos (MariaDB)..."
docker run -d --name wordpress-db \
    --mount source=wordpress-db,target=/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=wordpress \
    -e MYSQL_USER=manager \
    -e MYSQL_PASSWORD=secret \
    mariadb:10.3.9

echo "🌐 Creando contenedor de WordPress..."
docker run -d --name wordpress \
    --link wordpress-db:mysql \
    --mount type=bind,source="$(pwd)"/wordpress,target=/var/www/html \
    -e WORDPRESS_DB_USER=manager \
    -e WORDPRESS_DB_PASSWORD=secret \
    -p 8080:80 \
    wordpress:4.9.8

echo ""
echo "✅ Contenedores creados:"
echo "   - MariaDB: wordpress-db"
echo "   - WordPress: wordpress"
echo ""
echo "🌍 Abre http://localhost:8080 para configurar WordPress"
echo ""
echo "📝 Comandos útiles:"
echo "   docker ps                    # Ver contenedores activos"
echo "   docker logs wordpress        # Ver logs de WordPress"
echo "   docker exec -it wordpress bash  # Entrar al contenedor"
echo "   docker stop wordpress wordpress-db  # Detener"
echo "   docker rm -f wordpress wordpress-db  # Eliminar"