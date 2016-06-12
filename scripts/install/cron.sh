#!/bin/bash

# Logs
mkdir -p $DATA_DIRECTORY/logs/cron

# Loading permissions
chown -R www-data:www-data $DATA_DIRECTORY/logs/cron
