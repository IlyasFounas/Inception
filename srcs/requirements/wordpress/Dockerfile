# syntax=docker/dockerfile:1
FROM debian:13.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    gzip \
    wget \
    ca-certificates \
    lsb-release \
    gnupg2

# Add PHP repository
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# Install PHP and php-fpm
RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip

# Create the directory for WordPress
RUN mkdir -p /var/www/html

# Download and install WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf wordpress && \
    chown -R www-data:www-data /var/www/html

# Configure php-fpm
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/8.2/fpm/pool.d/www.conf && \
    sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/8.2/fpm/pool.d/www.conf && \
    sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]