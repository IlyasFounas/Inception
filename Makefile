.PHONY: up down clean rebuild stop logs logs-mariadb logs-wordpress logs-nginx stop-mariadb stop-wordpress stop-nginx

up:
	sudo chown -R ifounas:ifounas ~/data
	mkdir -p /home/ifounas/data/mariadb
	mkdir -p /home/ifounas/data/wordpress
	chmod 777 /home/ifounas/data/mariadb
	chmod 777 /home/ifounas/data/wordpress
	docker-compose up -d --build

down:
	docker-compose down

clean:
	docker-compose down --rmi local -v
	sudo chown -R ifounas:ifounas ~/data
	rm -rf /home/ifounas/data/mariadb
	rm -rf /home/ifounas/data/wordpress

rebuild:
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