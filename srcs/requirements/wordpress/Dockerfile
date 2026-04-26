FROM debian:13.0

# Installer les dépendances de base
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Ajouter le dépôt Sury pour PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# Installer PHP 8.2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-curl \
    && rm -rf /var/lib/apt/lists/*

# WP CLI to configure the wordpress website
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Télécharger WordPress
RUN mkdir -p /var/www/html && \
    curl -L https://wordpress.org/latest.tar.gz | tar -xz -C /var/www/html --strip-components=1 && \
    chown -R www-data:www-data /var/www/html

# Configurer PHP-FPM pour écouter sur le port 9000
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf && \
    sed -i 's/;listen.owner = www-data/listen.owner = www-data/' /etc/php/8.2/fpm/pool.d/www.conf && \
    sed -i 's/;listen.group = www-data/listen.group = www-data/' /etc/php/8.2/fpm/pool.d/www.conf

# Copier le script d'entrypoint
COPY wordpress.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/docker-entrypoint.sh"]