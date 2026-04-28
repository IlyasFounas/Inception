#!/bin/sh

set -e

# Set variables to connect to mariadb
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${WORDPRESS_USER:-wordpress}
DB_PASSWORD=${WORDPRESS_USER_PWD:-password}
DB_HOST=${WORDPRESS_ROOT:-mariadb}

# Set variables to configure wordpress
WP_URL=${DOMAIN_NAME:-localhost}
WP_TITLE=${WP_TITLE:-"Inception Site"}
WP_ADMIN_USER=${WP_ADMIN_USER:-webmaster}
WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD:-$(openssl rand -base64 12)}
WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-admin@example.com}

echo "Waiting for MariaDB at $DB_HOST..."
for i in $(seq 1 30); do
    if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; then
        echo "MariaDB ready."
        break
    fi
    echo "Attempt $i/30: not ready, sleep 2..."
    sleep 2
    if [ $i -eq 30 ]; then
        echo "ERROR: Could not connect to MariaDB after 60 seconds."
        exit 1
    fi
done

cd /var/www/html

# Create wp-config.php
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
    sed -i "s/username_here/$DB_USER/g" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$DB_HOST/g" wp-config.php
fi

# Configure the website
if ! wp core is-installed --allow-root --path=/var/www/html 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install --allow-root --path=/var/www/html \
        --url="https://$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

chmod 755 /var/www/html /var/www/html/wp-admin

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F