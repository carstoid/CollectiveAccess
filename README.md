# CollectiveAccess

Docker setup for English [CollectiveAccess](https://www.collectiveaccess.org), adapted from `artturimatias/CollectiveAccess`.

## Installation

Clone this repository and `cd` into it. Then:

```#sh
make create_db
make create_volume
make build
make start
```

Open [localhost/providence/install](http://localhost/providence/install) and follow the instructions. Choose '[DEFAULT] Visual Resources Collection' from the drop-down.

Stop: `docker stop collectiveaccess mariadb`
Start: `docker start mariadb collectiveaccess`
Enter container: `docker exec -it collectiveaccess bash`, exit with `Ctrl + D`
