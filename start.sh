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
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /archive.sh" | crontab -
    exec cron -f
fi
