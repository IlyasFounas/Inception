#!/bin/sh

# Récupérer les variables d'env
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${WORDPRESS_USER:-wordpress}
DB_PASSWORD=${WORDPRESS_USER_PWD:-password}
DB_HOST=${WORDPRESS_ROOT:-mariadb}

# Créer wp-config.php s'il n'existe pas
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    
    sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
    sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php
    sed -i "s/localhost/$DB_HOST/g" /var/www/html/wp-config.php
    
    echo "wp-config.php created"
fi

# Démarrer PHP-FPM immédiatement
echo "Starting PHP-FPM..."
exec php-fpm8.2 -F