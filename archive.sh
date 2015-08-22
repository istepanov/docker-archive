#!/bin/bash

set -e

DATE=$(date +%Y%m%d_%H%M%S)
FILE="/backup/$PREFIX-$DATE.tar.gz"

tar -zcvf "$FILE" $TAR_PARAMS /target
