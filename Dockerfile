# Utiliser l'image Nginx + PHP-FPM
FROM richarvey/nginx-php-fpm:3.1.6

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le code Laravel
COPY . /var/www/html

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Copier le script de démarrage
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Exposer le port Render (Render définit $PORT automatiquement)
EXPOSE 80

# Lancer le script de démarrage
CMD ["/startup.sh"]
