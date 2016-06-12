#!/bin/bash

# Logs
mkdir -p $DATA_DIRECTORY/logs/gitdaemon

# Loading permissions
chown -R www-data:www-data $DATA_DIRECTORY/logs/gitdaemon
