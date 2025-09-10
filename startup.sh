#!/bin/bash
set -e

echo "✅ Installation des dépendances Laravel"
composer install --no-interaction --prefer-dist --optimize-autoloader

echo "✅ Lancement des migrations (fresh + seed)"
php artisan migrate:fresh --seed --force

echo "✅ Démarrage de Nginx et PHP-FPM"

# Remplacer le port Nginx par celui fourni par Render
sed -i "s/listen 80;/listen ${PORT};/" /etc/nginx/sites-enabled/default.conf

# Lancer PHP-FPM
php-fpm &

# Lancer Nginx au premier plan (Render détectera ce processus)
nginx -g 'daemon off;'
