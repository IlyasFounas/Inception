.PHONY: up down clean rebuild stop logs

up:
	docker-compose up -d --build

down:
	docker-compose down

clean:
	docker-compose down --rmi local -v

rebuild:
	docker-compose build --no-cache
	docker-compose up -d

stop:
	docker-compose stop

logs:
	docker-compose logs -f