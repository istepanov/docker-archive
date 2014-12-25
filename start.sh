#!/bin/bash

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}

echo "$CRON_SCHEDULE /archive.sh" | crontab -
exec cron -f
