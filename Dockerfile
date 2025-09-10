FROM richarvey/nginx-php-fpm:3.1.6

WORKDIR /var/www/html

# Copier les fichiers composer
COPY composer.json composer.lock ./

# Installer les dépendances
RUN composer install --no-dev --optimize-autoloader

# Copier le reste du projet
COPY . /var/www/html

# Variables d'environnement
ENV WEBROOT=/var/www/html/public \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr

# Copier la config nginx (à créer)
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Startup script Laravel uniquement
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Commande d’exécution Render
CMD ["/startup.sh"]
