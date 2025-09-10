FROM richarvey/nginx-php-fpm:3.1.6

# Définir le répertoire de travail
WORKDIR /var/www/html

# Étape 1 : copier artisan + composer.* pour que composer puisse exécuter ses scripts
COPY composer.json composer.lock artisan ./

# Étape 2 : installer les dépendances Laravel
RUN composer install --no-dev --optimize-autoloader

# Étape 3 : copier le reste du code de l'application
COPY . /var/www/html

# Variables d'environnement Laravel & PHP
ENV WEBROOT=/var/www/html/public \
    PHP_ERRORS_STDERR=1 \
    RUN_SCRIPTS=1 \
    REAL_IP_HEADER=1 \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr \
    COMPOSER_ALLOW_SUPERUSER=1 \
    SKIP_COMPOSER=1

# Étape 4 : copier la config nginx optimisée
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Étape 5 : ajouter le script de démarrage personnalisé
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Commande de démarrage
CMD ["/startup.sh"]
