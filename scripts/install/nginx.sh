#!/bin/bash

# Vhosts
echo "Loading Nginx vhosts..."

rm -f /etc/nginx/sites-enabled/*

if [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ] && [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.crt" ]; then

    echo "Generating self-signed HTTPS Certificates..."
    openssl req \
        -x509 \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout "${DATA_DIRECTORY}/certs/toran-proxy.key" \
        -out "${DATA_DIRECTORY}/certs/toran-proxy.crt" \
        -subj "/C=SS/ST=SS/L=SelfSignedCity/O=SelfSignedOrg/CN=gitweb.local"

elif [ -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ] && [ -e "${DATA_DIRECTORY}/certs/toran-proxy.crt" ]; then

    echo "Using provided HTTPS Certificates..."

else

    if [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ]; then
        echo "ERROR: " >&2
        echo "  File toran-proxy.key exists in folder certs/ but no toran-proxy.crt" >&2
        exit 1
    else
        echo "ERROR: " >&2
        echo "  File toran-proxy.crt exists in folder certs/ but no toran-proxy.key" >&2
        exit 1
    fi

fi

echo "Loading HTTPS Certificates..."

# Add certificates trusted
ln -s ${DATA_DIRECTORY}/certs /usr/local/share/ca-certificates/toran-proxy
update-ca-certificates

ln -s /etc/nginx/sites-available/toran-proxy.conf /etc/nginx/sites-enabled/toran-proxy.conf

# Logs
mkdir -p ${DATA_DIRECTORY}/logs/nginx

# Loading permissions
chown -R www-data:www-data \
    ${DATA_DIRECTORY}/logs/nginx
