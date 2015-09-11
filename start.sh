#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
PREFIX=${PREFIX:-backup}

if [[ "$1" == 'no-cron' ]]; then
    exec /archive.sh
else
    CRON_ENV="PREFIX=$PREFIX"
    if [ -n "$TAR_PARAMS" ]; then
        CRON_ENV="$CRON_ENV\nTAR_PARAMS=$TAR_PARAMS"
    fi
    touch /var/log/cron.log
    echo -e "$CRON_ENV\n\n$CRON_SCHEDULE /archive.sh >> /var/log/cron.log 2>&1" | crontab -
    exec cron -f
fi
