FROM richarvey/nginx-php-fpm:3.1.6

WORKDIR /var/www/html

# Copier tout le projet avant d'installer les dépendances
COPY . /var/www/html

# Installer les dépendances Laravel
RUN composer install --no-dev --optimize-autoloader

# Variables d'environnement Laravel & PHP
ENV WEBROOT=/var/www/html/public \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr \
    COMPOSER_ALLOW_SUPERUSER=1

# Copier la config nginx
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Script startup Laravel uniquement
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Commande d’exécution Render
CMD ["/startup.sh"]
