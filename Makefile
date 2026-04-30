.PHONY: up down clean rebuild stop logs logs-mariadb logs-wordpress logs-nginx stop-mariadb stop-wordpress stop-nginx

COMPOSE_FILE = srcs/docker-compose.yml

up:
	mkdir -p /home/ifounas/data/mariadb
	mkdir -p /home/ifounas/data/wordpress
	sudo chown -R 999:999 /home/ifounas/data/mariadb
	sudo chmod -R 775 /home/ifounas/data/mariadb
	sudo chown -R 33:33 /home/ifounas/data/wordpress
	sudo chmod -R 755 /home/ifounas/data/wordpress
	docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	docker-compose -f $(COMPOSE_FILE) down

fclean:
	docker-compose -f $(COMPOSE_FILE) down --rmi local -v
	sudo rm -rf /home/ifounas/data/mariadb
	sudo rm -rf /home/ifounas/data/wordpress

re:
	docker-compose -f $(COMPOSE_FILE) build --no-cache --pull
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose -f $(COMPOSE_FILE) stop

stop-mariadb:
	docker-compose -f $(COMPOSE_FILE) stop mariadb

stop-wordpress:
	docker-compose -f $(COMPOSE_FILE) stop wordpress

stop-nginx:
	docker-compose -f $(COMPOSE_FILE) stop nginx

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

logs-mariadb:
	docker-compose -f $(COMPOSE_FILE) logs -f mariadb

logs-wordpress:
	docker-compose -f $(COMPOSE_FILE) logs -f wordpress

logs-nginx:
	docker-compose -f $(COMPOSE_FILE) logs -f nginx