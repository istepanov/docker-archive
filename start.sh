#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
PREFIX=${PREFIX:-backup}

if [[ "$1" == 'no-cron' ]]; then
    exec /archive.sh
else
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    CRON_ENV="PREFIX=$PREFIX"
    if [ -n "$TAR_PARAMS" ]; then
        CRON_ENV="$CRON_ENV\nTAR_PARAMS=$TAR_PARAMS"
    fi
    echo -e "$CRON_ENV\n\n$CRON_SCHEDULE /archive.sh > $LOGFIFO 2>&1" | crontab -
    crontab -l
    cron
    tail -f "$LOGFIFO"
fi
