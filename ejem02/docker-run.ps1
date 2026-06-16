# ============================================
# ejem02 - WordPress + MariaDB con --link
# Versión para PowerShell (Windows)
# ============================================

Write-Host "📁 Creando directorio wordpress/" -ForegroundColor Cyan
New-Item -ItemType Directory -Path "wordpress" -Force | Out-Null

Write-Host "🐳 Creando contenedor de base de datos (MariaDB)..." -ForegroundColor Cyan
docker run -d --name wordpress-db `
    --mount source=wordpress-db,target=/var/lib/mysql `
    -e MYSQL_ROOT_PASSWORD=secret `
    -e MYSQL_DATABASE=wordpress `
    -e MYSQL_USER=manager `
    -e MYSQL_PASSWORD=secret `
    mariadb:10.3.9

Write-Host "🌐 Creando contenedor de WordPress..." -ForegroundColor Cyan
docker run -d --name wordpress `
    --link wordpress-db:mysql `
    --mount type=bind,source="$PWD\wordpress",target=/var/www/html `
    -e WORDPRESS_DB_USER=manager `
    -e WORDPRESS_DB_PASSWORD=secret `
    -p 8080:80 `
    wordpress:4.9.8

Write-Host ""
Write-Host "✅ Contenedores creados:" -ForegroundColor Green
Write-Host "   - MariaDB: wordpress-db"
Write-Host "   - WordPress: wordpress"
Write-Host ""
Write-Host "🌍 Abre http://localhost:8080 para configurar WordPress" -ForegroundColor Yellow