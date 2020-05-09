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

NOTE: as permissions aren't set properly in the dockerfile, you may need to enter the container and run `chown -R www-data: /path/to/tilepics/` before image upload will work. You'll also need to set up geonames

You can back up the data volumes with loomchild/volume-backup"
`docker run -v ca_vol:/volume -v ~/Desktop/collectiveaccess_setup/backups:/backup --rm loomchild/volume-backup backup ca_vol`
`docker run -v ca_mariadb_vol:/volume -v ~/Desktop/collectiveaccess_setup/backups:/backup --rm loomchild/volume-backup backup ca_mariadb_vol`

Restore with
`docker run -v ca_vol:/volume -v ~/Desktop/collectiveaccess_setup/backups:/backup --rm loomchild/volume-backup restore ca_vol`
`docker run -v ca_mariadb_vol:/volume -v ~/Desktop/collectiveaccess_setup/backups:/backup --rm loomchild/volume-backup restore ca_mariadb_vol`

## Data Imports

Data can be imported following these [instructions](https://docs.collectiveaccess.org/wiki/Basic_data_import_tutorial)

## Data Model

The Collective Access Data Model is made up of:

- [Label Bundles](https://docs.collectiveaccess.org/wiki/Label_Bundles)
- [Intrinsic Bundles](https://docs.collectiveaccess.org/wiki/Intrinsic_Bundles)
- User-Defined Metadata, accessed under Metadata Elements in the web UI

https://gitter.im/collectiveaccess/support?at=5b047c10556e4c40fb61bde2

Changes to make after 5/3 metadata import debugging:
- change default number of dates allowed for each item (was 1, set to at least 2 before import but likely more would be better esp for bldgs)
- multipart_id_num setting to 8 chars for occurrences (bldgs)
- show "undated" to 1 (app.conf?)
- install nano for troubleshooting
- set geonames_user from docker run command
- turn off auto-configured identifier for list items/vocab
- add occurrence type buildings
- add date types commissioned, completed 
