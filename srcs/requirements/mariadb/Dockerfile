# syntax=docker/dockerfile:1
FROM debian:13.0

RUN apt update -y && \
    apt install -y mariadb-server mariadb-client galera-4 && \
    rm -rf /var/lib/apt/lists/*

RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# run the script to create the table
COPY srcs/requirements/mariadb/init_mariadb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init_mariadb.sh

RUN chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

CMD ["mysqld"]