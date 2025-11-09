#!/bin/sh

echo "Starting Laravel production container..."

# 1️⃣ Generate APP_KEY if missing
if [ -z "$APP_KEY" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --ansi
fi

# 2️⃣ Clear and cache config, routes, views
echo "Optimizing Laravel..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 3️⃣ Run migrations (optional)
if [ "$RUN_MIGRATIONS" = "true" ]; then
    echo "Running migrations..."
    php artisan migrate --force
fi

# Start PHP-FPM in foreground on port 80
php-fpm -F

# 4️⃣ Start PHP-FPM and Nginx (commented in render)
# php-fpm -D
# nginx -g "daemon off;"
