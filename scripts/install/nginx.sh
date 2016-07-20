#!/bin/bash

# Vhosts
echo "Loading Nginx vhosts..."

TORAN_HOST=${TORAN_HOST:-localhost}

rm -f /etc/nginx/sites-enabled/*

if [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ] && [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.crt" ]; then
    SSL_CERT_SUBJ="/C=SS/ST=SS/L=SelfSignedCity/O=SelfSignedOrg/CN=${TORAN_HOST}"

    echo "Generating self-signed HTTPS Certificates..."

    mkdir -p ${DATA_DIRECTORY}/certs

    openssl req \
        -x509 \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout "${DATA_DIRECTORY}/certs/toran-proxy.key" \
        -out "${DATA_DIRECTORY}/certs/toran-proxy.crt" \
        -subj "${SSL_CERT_SUBJ}"

elif [ -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ] && [ -e "${DATA_DIRECTORY}/certs/toran-proxy.crt" ]; then

    echo "Using provided HTTPS Certificates..."

else

    if [ ! -e "${DATA_DIRECTORY}/certs/toran-proxy.key" ]; then
        echo "ERROR: "
        echo "  File toran-proxy.key exists in folder certs/ but no toran-proxy.crt"
        exit 1
    else
        echo "ERROR: "
        echo "  File toran-proxy.crt exists in folder certs/ but no toran-proxy.key"
        exit 1
    fi

fi

echo "Loading HTTPS Certificates..."

# Add certificates trusted
mkdir -p /usr/local/share/ca-certificates/toran-proxy
cp -f ${DATA_DIRECTORY}/certs/* /usr/local/share/ca-certificates/toran-proxy
update-ca-certificates

ln -s /etc/nginx/sites-available/toran-proxy.conf /etc/nginx/sites-enabled/toran-proxy.conf
