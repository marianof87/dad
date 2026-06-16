#!/bin/bash
# ============================================
# ejem03 - WordPress + MariaDB con red propia
# ============================================
# Crea una red Docker personalizada y ejecuta
# MariaDB y WordPress en ella.
# Ventaja: comunicación por nombre de servicio
# sin depender de --link (deprecated)
# ============================================

# Crear directorio para WordPress (bind mount local)
echo "📁 Creando directorio wordpress/"
mkdir -p wordpress

# Crear red propia
echo "🌐 Creando red Docker 'mi-network'..."
docker network create mi-network

echo "🐳 Creando contenedor de base de datos (MariaDB)..."
docker run -d --name wordpress-db \
    --net=mi-network \
    --mount source=wordpress-db,target=/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=wordpress \
    -e MYSQL_USER=manager \
    -e MYSQL_PASSWORD=secret \
    mariadb:10.3.9

echo "🌐 Creando contenedor de WordPress..."
docker run -d --name wordpress \
    --net=mi-network \
    --link wordpress-db:mysql \
    --mount type=bind,source="$(pwd)"/wordpress,target=/var/www/html \
    -e WORDPRESS_DB_USER=manager \
    -e WORDPRESS_DB_PASSWORD=secret \
    -p 8080:80 \
    wordpress:4.9.8

echo ""
echo "✅ Contenedores creados en 'mi-network':"
echo "   - MariaDB: wordpress-db"
echo "   - WordPress: wordpress"
echo ""
echo "🌍 Abre http://localhost:8080 para configurar WordPress"
echo ""
echo "📝 Comandos útiles:"
echo "   docker network ls            # Ver redes"
echo "   docker network inspect mi-network  # Ver detalle de la red"
echo "   docker ps                    # Ver contenedores activos"
echo "   docker logs wordpress        # Ver logs de WordPress"
echo "   docker exec -it wordpress bash  # Entrar al contenedor"
echo ""
echo "⚠️  Nota sobre portabilidad:"
echo "   Este script usa bash y comandos de Linux (mkdir, pwd)."
echo "   En Windows PowerShell usa: docker-run.ps1"