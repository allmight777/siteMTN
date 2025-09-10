FROM richarvey/nginx-php-fpm:3.1.6

# Copier le code Laravel
COPY . /var/www/html

WORKDIR /var/www/html

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Copier le script de démarrage
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
