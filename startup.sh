#!/bin/bash
set -e

echo "✅ Installation des dépendances Laravel"
composer install --no-interaction --prefer-dist --optimize-autoloader

echo "✅ Nettoyage des caches"
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "✅ Lancement des migrations et seeds"
php artisan migrate:fresh --seed --force

echo "✅ Démarrage de Nginx + PHP-FPM"
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
