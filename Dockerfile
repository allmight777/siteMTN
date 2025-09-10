FROM richarvey/nginx-php-fpm:3.1.6

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier uniquement les fichiers composer pour installer les dépendances
COPY composer.json composer.lock ./

# Installer les dépendances Laravel
RUN composer install --no-dev --optimize-autoloader

# Copier le reste du code de l'application
COPY . /var/www/html

# Variables d'environnement Laravel & PHP
ENV WEBROOT /var/www/html/public \
    PHP_ERRORS_STDERR=1 \
    RUN_SCRIPTS=1 \
    REAL_IP_HEADER=1 \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr \
    COMPOSER_ALLOW_SUPERUSER=1 \
    SKIP_COMPOSER=1

# Copier la config nginx optimisée (tu la créeras dans ./nginx/default.conf)
COPY nginx.conf /etc/nginx/sites-enabled/default.conf

# Ajouter le script de démarrage personnalisé
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Commande de démarrage
CMD ["/startup.sh"]
