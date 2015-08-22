Docker image for backing up folders to tar.gz archives
================

Docker image that periodically archives a folder to tar.gz file.

### Usage

	docker run -d [OPTIONS] istepanov/archive [no-cron]

### Required parameters

* `-v /target/dir/:/target:ro`: mount target local folder to container's data folder. Content of this folder will be archived into tar.gz file
* `-v /backup/dir/:/backup`: folder where tar.gz files will be stored

### Optional parameters

* `-e 'CRON_SCHEDULE=0 1 * * *'`: specifies when cron job starts ([details](http://en.wikipedia.org/wiki/Cron)). Default is `0 1 * * *` (runs every day at 1:00 am).
* `no-cron`: run container once and exit (no cron scheduling).
* `-e 'PREFIX=backup'`: tar.gz filename prefix. Default is 'backup'. Tar.gz filename format is `PREFIX-YYYYMMDD_hhmmss.tar.gz`
* `-e 'TAR_PARAMS=--param1=value1 --param2=value2'`: additional parameters passed to tar. For instance, `--exclude=filename`.
* `no-cron`: run container once and exit (no cron scheduling).

### Upload to AWS S3

Need to upload archives to AWS S3? Use [istepanov/backup-to-s3](https://github.com/istepanov/docker-backup-to-s3).


### Examples

Archive folder every day at 12:00pm:

    docker run -d \
    	-v /home/username/data/:/target:ro \
    	-v /home/username/backup:/backup \
		-e 'CRON_SCHEDULE=0 12 * * *' \
		istepanov/archive				

Run once then delete the container, ignore `.git` folders:

	docker run --rm \
		-v /home/username/data/:/target \
		-v /home/username/backup:/backup \
		-e 'TAR_PARAMS=--exclude=.git' \
		istepanov/archive no-cron
