#!/bin/bash
set -e

echo "Starting MariaDB"
mysqld --user=mysql --skip-networking &

echo "Waiting for MariaDB to be ready..."
for i in {1..30}; do
    if mysqladmin ping --silent; then
        echo "MariaDB is ready!"
        break
    fi
    echo "Waiting... (attempt $i/30)"
    sleep 2
    if [ $i -eq 30 ]; then
        echo "ERROR: MariaDB failed to start"
        exit 1
    fi
done

if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "Running initialization script..."
    /init_mariadb.sh
    touch /var/lib/mysql/.initialized
    echo "Initialization completed."
else
    echo "Database already initialized."
fi

mysqladmin shutdown -uroot -p"${MYSQL_ROOT_PASSWORD}"

echo "MariaDB has started"
exec mysqld --user=mysql
