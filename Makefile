.PHONY: up down clean rebuild stop logs logs-mariadb logs-wordpress logs-nginx stop-mariadb stop-wordpress stop-nginx

up:
	mkdir -p /home/ifounas/data/mariadb
	mkdir -p /home/ifounas/data/wordpress
	# Donner les permissions à l'utilisateur mysql (UID 999)
	sudo chown -R 999:999 /home/ifounas/data/mariadb
	sudo chmod -R 755 /home/ifounas/data/mariadb
	# Donner les permissions à www-data (UID 33) pour WordPress
	sudo chown -R 33:33 /home/ifounas/data/wordpress
	sudo chmod -R 755 /home/ifounas/data/wordpress
	docker-compose up -d --build

down:
	docker-compose down

fclean:
	docker-compose down --rmi local -v
	sudo rm -rf /home/ifounas/data/mariadb
	sudo rm -rf /home/ifounas/data/wordpress

re:
	docker-compose build --no-cache --pull
	docker-compose up -d

stop:
	docker-compose stop

stop-mariadb:
	docker-compose stop mariadb

stop-wordpress:
	docker-compose stop wordpress

stop-nginx:
	docker-compose stop nginx

logs:
	docker-compose logs -f

logs-mariadb:
	docker-compose logs -f mariadb

logs-wordpress:
	docker-compose logs -f wordpress

logs-nginx:
	docker-compose logs -f nginx