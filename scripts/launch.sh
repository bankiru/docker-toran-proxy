#!/bin/bash

DATA_DIRECTORY=/data
WORK_DIRECTORY=/var/www
ASSETS_DIRECTORY=/assets
SCRIPTS_DIRECTORY=/toran-proxy

# Recreate logs directory
if [ -d ${DATA_DIRECTORY}/logs ]; then
    echo "Recreating logs directory..."
    rm -rf ${DATA_DIRECTORY}/logs
else
    echo "Creating logs directory..."
fi
mkdir ${DATA_DIRECTORY}/logs
chown -R www-data:www-data ${DATA_DIRECTORY}/logs

# Initilisation
source ${SCRIPTS_DIRECTORY}/install/php-fpm.sh
source ${SCRIPTS_DIRECTORY}/install/nginx.sh
source ${SCRIPTS_DIRECTORY}/install/ssh.sh
source ${SCRIPTS_DIRECTORY}/install/toran.sh

# Start services
echo "Starting Toran Proxy..."
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
