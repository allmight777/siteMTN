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

echo "✅ ✅ Laravel prêt ! Le serveur nginx + PHP-FPM est déjà lancé par l'image."
