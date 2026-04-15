make nginx:
	docker build -t inception-nginx -f srcs/requirements/nginx/Dockerfile .
	make start-nginx

start-nginx:
	docker run -d -p 443:443 --name inception-nginx-container inception-nginx

stop-nginx:
	docker stop inception-nginx-container || true

clean-nginx:
	docker stop inception-nginx-container || true
	docker rm inception-nginx-container || true

# Règles pour MariaDB
make mariadb:
	docker build -t inception-mariadb -f srcs/requirements/mariadb/Dockerfile .
	make start-mariadb

start-mariadb:
	docker run -d -p 3306:3306 --name inception-mariadb-container \
		-v /home/$(USER)/data/mariadb:/var/lib/mysql \
		--network=inception_network \
		--restart unless-stopped \
		inception-mariadb

stop-mariadb:
	docker stop inception-mariadb-container || true

clean-mariadb:
	docker stop inception-mariadb-container || true
	docker rm inception-mariadb-container || true

clean-all: clean-mariadb clean-nginx
	docker rmi inception-mariadb || true