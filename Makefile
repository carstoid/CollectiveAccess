
IMAGES := $(shell docker images -f "dangling=true" -q)
CONTAINERS := $(shell docker ps -a -q -f status=exited)
VOLUME := ca_vol
NETWORK := ca_net
DB := c_access
VERSION := 1.7.8

clean:
	docker rm -f $(CONTAINERS) \
	docker rmi -f $(IMAGES)

create_network:
	docker network create $(NETWORK)

create_volume:
	docker volume create $(VOLUME)

create_db:
	docker run --name ca_mariadb \
	--network $(NETWORK) \
	-v ca_mariadb_vol:/var/lib/mysql \
 	-e MYSQL_ROOT_PASSWORD=root \
	-d mariadb:10.3.7

build:
	docker build -t artturimatias/collectiveaccess:$(VERSION) .
	
start:
	docker run -d --name ca_app \
	-p 8246:80 \
	-v $(VOLUME):/var/www/providence/media \
	--network $(NETWORK) \
	-e DB_HOSTNAME=ca_mariadb \
	-e DB_USER=root \
	-e DB_PW=root \
	-e DB_NAME=$(DB) \
	artturimatias/collectiveaccess:$(VERSION)

remove:
	docker stop collectiveaccess
	docker rm collectiveaccess
