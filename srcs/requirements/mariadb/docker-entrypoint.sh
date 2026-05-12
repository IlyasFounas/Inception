#!/bin/bash
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "Preparing SQL initialization..."
    
    cat > /tmp/init.sql <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    touch /var/lib/mysql/.initialized
    exec mysqld --user=mysql --datadir=/var/lib/mysql --init-file=/tmp/init.sql --bind-address=0.0.0.0
else
    echo "Database already initialized."
    exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
fi