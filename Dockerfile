FROM richarvey/nginx-php-fpm:3.1.6

WORKDIR /var/www/html

# Étape 1 : copier tout le projet
COPY . /var/www/html

# Étape 2 : installer les dépendances
RUN composer install --no-dev --optimize-autoloader

# Variables d'environnement
ENV WEBROOT=/var/www/html/public \
    PHP_ERRORS_STDERR=1 \
    RUN_SCRIPTS=1 \
    REAL_IP_HEADER=1 \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr \
    COMPOSER_ALLOW_SUPERUSER=1 \
    SKIP_COMPOSER=1

# Étape 3 : config nginx
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Étape 4 : script startup
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
