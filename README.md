# 🐳 Docker Tutorial - Ejemplos Prácticos

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Docker](https://img.shields.io/badge/Docker-27.x-2496ED?logo=docker)
![PHP](https://img.shields.io/badge/PHP-8.2-777BB4?logo=php)

Ejemplos prácticos de Docker adaptados y actualizados del tutorial de [joseluisgs/docker-tutorial](https://github.com/joseluisgs/docker-tutorial), originalmente creado para el módulo **2DAW (Desarrollo Avanzado de Código)**.

---

## 📋 Contenido

| Ejemplo                                           | Descripción                                | Tecnologías                 |
| ------------------------------------------------- | ------------------------------------------ | --------------------------- |
| [ejem01](#ejem01---php-82--apache)                | PHP + Apache con **bind mount** y editores | PHP 8.2, Apache, Vim, Nano  |
| [ejem02](#ejem02---wordpress--mariadb---link)     | WordPress + MariaDB con `--link` (legacy)  | WordPress 4.9, MariaDB 10.3 |
| [ejem03](#ejem03---wordpress--mariadb-red-propia) | WordPress + MariaDB con **red propia**     | WordPress 4.9, MariaDB 10.3 |

---

Para ejem09

Los contenedores de ejem09 están corriendo sin problemas:

reverseproxy (Nginx proxy) -> Escuchando en los puertos 8080 y 8081
nginx (Sitio 1)
apache (Sitio 2)

correr podman ps en terminal para ver el estado de los contenedores

### 📋 Script de prueba para ejem09

Puedes ejecutar todo el flujo con:

```bash
cd docker-tutorial/ejemplos/ejem09
./run_ejem09.sh
```

El script:

- Levanta los contenedores (`podman compose up -d`).
- Espera brevemente para que inicien.
- Realiza peticiones `curl` a los puertos 8080 y 8081 para comprobar que el reverse‑proxy funciona.
- Muestra los contenedores activos (`podman ps`).
- Finalmente los detiene (`podman compose down`).

---

## 📂 Estructura del proyecto

```
docker-tutorial-ejemplos/
├── README.md                  # Este archivo
├── LICENSE                    # Licencia MIT
│
├── ejem01/                    # PHP 8.2 + Apache con Vim
│   ├── Dockerfile             # Imagen con PHP 8.2, Vim y Nano
│   ├── run.sh                 # Build + run (Linux/macOS)
│   └── src/
│       ├── index.html         # Página principal
│       ├── otra.html          # Página secundaria
│       └── prueba.php         # phpinfo()
│
├── ejem02/                    # WordPress + MariaDB (--link legacy)
│   ├── run.sh                 # Script para Linux/macOS (bash)
│   └── docker-run.ps1         # Script para Windows (PowerShell)
│
└── ejem03/                    # WordPress + MariaDB (red propia)
    ├── run.sh                 # Script para Linux/macOS (bash)
    └── docker-run.ps1         # Script para Windows (PowerShell)
```

---

## 🚀 Cómo usar

### ejem01 - PHP 8.2 + Apache

Construye una imagen con Apache, PHP 8.2, Vim y Nano, y monta el código fuente como **bind mount** para editar en tiempo real.

```powershell
# 1. Ir al directorio
cd ejem01

# 2. Construir la imagen
docker build -t miapache-php .

# 3. Ejecutar el contenedor (bind mount a src/)
docker run -dit --name miapache-php -p 5555:80 `
    --mount type=bind,source="$PWD\src",target=/var/www/html `
    miapache-php
```

```bash
# Linux/macOS
cd ejem01
chmod +x run.sh
./run.sh
```

🌍 **Abrir en navegador:** [http://localhost:5555](http://localhost:5555)

---

### ejem02 - WordPress + MariaDB (--link)

Usa el mecanismo `--link` (legacy) para conectar WordPress con MariaDB.

```powershell
cd ejem02
.\docker-run.ps1
```

```bash
cd ejem02
chmod +x run.sh
./run.sh
```

🌍 **Abrir en navegador:** [http://localhost:8080](http://localhost:8080)

---

### ejem03 - WordPress + MariaDB (red propia)

Crea una **red Docker personalizada** (`mi-network`) para la comunicación entre contenedores. Es el enfoque moderno y recomendado.

```powershell
cd ejem03
.\docker-run.ps1
```

```bash
cd ejem03
chmod +x run.sh
./run.sh
```

🌍 **Abrir en navegador:** [http://localhost:8080](http://localhost:8080)

---

## 📝 Edición dentro del contenedor (ejem01)

El Dockerfile de `ejem01` ya incluye **Vim** y **Nano** preinstalados.

### Con Vim

```bash
# Entrar al contenedor
docker exec -it miapache-php bash

# Editar index.html
vi index.html
```

**Comandos básicos de Vim:**
| Acción | Teclas |
|--------|--------|
| Modo insertar | `i` |
| Salir del modo insertar | `ESC` |
| Guardar y salir | `ESC` → `:wq` → `Enter` |
| Salir sin guardar | `ESC` → `:q!` → `Enter` |
| Buscar texto | `ESC` → `/texto` → `Enter` |

### Con Nano (más sencillo)

```bash
nano index.html
```

| Acción  | Teclas     |
| ------- | ---------- |
| Guardar | `Ctrl + O` |
| Salir   | `Ctrl + X` |
| Buscar  | `Ctrl + W` |

### Desde VS Code (si Docker está configurado)

1. Instalar la extensión **Remote Explorer**
2. Conectar al contenedor `miapache-php`
3. Editar `index.html` directamente desde VS Code

---

## ⚠️ Portabilidad de scripts (ejem02 vs ejem03)

Los scripts `run.sh` originales están escritos en **bash** y NO funcionan directamente en Windows.

| Comando          | Linux/macOS (bash) | Windows (PowerShell)           |
| ---------------- | ------------------ | ------------------------------ |
| Crear directorio | `mkdir -p`         | `New-Item -ItemType Directory` |
| Ruta actual      | `$(pwd)`           | `$PWD`                         |
| Ejecutable       | `./run.sh`         | `.\docker-run.ps1`             |

Por eso cada ejemplo incluye **dos versiones**:

- `run.sh` → Linux/macOS con bash
- `docker-run.ps1` → Windows con PowerShell

---

## 🔧 Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/Mac) o Docker Engine (Linux)
- Powershell (Windows) o Bash (Linux/macOS)
- Git (para clonar el repositorio)

---

## 📸 Capturas de pantalla

> _(Agrega aquí tus capturas de pantalla)_
>
> | Captura                            | Descripción                                              |
> | ---------------------------------- | -------------------------------------------------------- |
> | `screenshots/ejem01-navegador.png` | Navegador mostrando http://localhost:5555 con index.html |
> | `screenshots/ejem01-vim.png`       | Editando index.html con Vim dentro del contenedor        |
> | `screenshots/ejem02-wordpress.png` | WordPress funcionando en http://localhost:8080           |
> | `screenshots/docker-ps.png`        | `docker ps` mostrando los contenedores activos           |
> | `screenshots/docker-desktop.png`   | Docker Desktop con los contenedores visibles             |

---

## 📚 Fuente original

Este proyecto está basado en el tutorial de:

**José Luis González Sánchez**

- [docker-tutorial (original)](https://github.com/joseluisgs/docker-tutorial)
- [Twitter/X](https://twitter.com/joseluisgonsan)
- [GitHub](https://github.com/joseluisgs)

---

## 📄 Licencia

Este proyecto está bajo licencia **MIT**. Ver [LICENSE](LICENSE) para más detalles.
