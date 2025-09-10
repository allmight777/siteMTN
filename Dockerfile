FROM richarvey/nginx-php-fpm:3.1.6

WORKDIR /var/www/html

# Étape 1 : copier ce qui est nécessaire à Composer + artisan
COPY composer.json composer.lock artisan ./
COPY bootstrap/ ./bootstrap/
COPY config/ ./config/

# Étape 2 : installer les dépendances
RUN composer install --no-dev --optimize-autoloader

# Étape 3 : copier le reste du projet
COPY . /var/www/html

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

# Config Nginx
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Script startup
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
