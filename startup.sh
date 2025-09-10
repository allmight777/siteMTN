#!/bin/bash
set -e

echo "✅ Ajustement de Nginx pour Render"
# Remplacer le port 80 par le port fourni par Render
sed -i "s/listen 80;/listen ${PORT};/" /etc/nginx/sites-enabled/default.conf

echo "✅ Lancer les migrations et le seeding"
php artisan migrate:fresh --seed --force

echo "✅ Lancer PHP-FPM en arrière-plan"
php-fpm &

echo "✅ Lancer Nginx au premier plan"
nginx -g 'daemon off;'
