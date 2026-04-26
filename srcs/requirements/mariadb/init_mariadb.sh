#!/bin/bash
set -e

echo "Initializing MariaDB..."

# Attendre que MariaDB soit prête
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Créer la base de données et l'utilisateur
mysql -u root <<EOF
-- Changer le mot de passe root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE User='';

-- Supprimer la base de test
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';

-- Créer la base de données
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Créer l'utilisateur WordPress
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Donner les droits
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Recharger les privilèges
FLUSH PRIVILEGES;
EOF

echo "MariaDB initialization completed."