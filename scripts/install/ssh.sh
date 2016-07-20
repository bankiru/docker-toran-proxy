#!/bin/bash

# Installing ssh keys
if [ -e "${DATA_DIRECTORY}/ssh" ]; then

    echo "Installing ssh config..."

    SSH_DIRECTORY=${WORK_DIRECTORY}/.ssh

    mkdir ${SSH_DIRECTORY}

    if [ -e "${DATA_DIRECTORY}/ssh/id_rsa" ]; then
        chgrp 545 ${DATA_DIRECTORY}/ssh/id_rsa
        chmod 600 ${DATA_DIRECTORY}/ssh/id_rsa
        ln -s ${DATA_DIRECTORY}/ssh/id_rsa ${SSH_DIRECTORY}/id_rsa
    fi

    if [ -e "${DATA_DIRECTORY}/ssh/id_rsa.pub" ]; then
        chmod 644 ${DATA_DIRECTORY}/ssh/id_rsa.pub
        ln -s ${DATA_DIRECTORY}/ssh/id_rsa.pub ${SSH_DIRECTORY}/id_rsa.pub
    fi

    if [ -e "${DATA_DIRECTORY}/ssh/known_hosts" ]; then
        chmod 644 ${DATA_DIRECTORY}/ssh/known_hosts
        ln -s ${DATA_DIRECTORY}/ssh/known_hosts ${SSH_DIRECTORY}/known_hosts
    fi

    if [ -e "${DATA_DIRECTORY}/ssh/config" ]; then
        chmod 644 ${DATA_DIRECTORY}/ssh/config
        ln -s ${DATA_DIRECTORY}/ssh/config ${SSH_DIRECTORY}/config
    fi

    chmod 700 ${DATA_DIRECTORY}/ssh
    chown -R www-data:www-data ${DATA_DIRECTORY}/ssh

fi
