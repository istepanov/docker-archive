#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
PREFIX=${PREFIX:-backup}

if [[ "$1" == 'no-cron' ]]; then
    exec /archive.sh
else
    echo -e "PREFIX=$PREFIX\nTAR_PARAMS=$TAR_PARAMS\n$CRON_SCHEDULE /archive.sh" | crontab -
    exec cron -f
fi
