#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)
FILE="/backup/backup-$DATE.tar.gz"

tar -zcvf "$FILE" /target
