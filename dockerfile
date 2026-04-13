FROM php:8.3-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    nginx \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio
WORKDIR /var/www

# Copiar proyecto
COPY . .

# Instalar Laravel
RUN composer install --optimize-autoloader --no-dev

# Permisos
RUN chown -R www-data:www-data /var/www

# Configurar Nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Exponer puerto HTTP
EXPOSE 80

# Iniciar servicios
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]