# FROM debian:13.0

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     mariadb-server \
#     mariadb-client \
#     && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /run/mysqld && \
#     chown -R mysql:mysql /run/mysqld

# COPY init_mariadb.sh /docker-entrypoint-initdb.d/
# RUN chmod +x /docker-entrypoint-initdb.d/init_mariadb.sh

# # Configurer MariaDB pour écouter sur toutes les interfaces
# RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# RUN chown -R mysql:mysql /var/lib/mysql

# EXPOSE 3306

# USER mysql
# CMD ["mysqld"]

FROM debian:13.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# Copier le script d'initialisation
COPY init_mariadb.sh /init_mariadb.sh
RUN chmod +x /init_mariadb.sh

# Configurer MariaDB pour écouter sur toutes les interfaces
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

# Utiliser un script d'entrypoint qui démarre MariaDB ET exécute l'initialisation
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]