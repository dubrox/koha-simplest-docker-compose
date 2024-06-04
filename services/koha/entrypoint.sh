#!/bin/bash

if [ ! -f "/etc/koha/sites/${KOHA_INSTANCE}/koha_conf.xml" ]
then
    echo "Setting up Koha for the first time..."

    # https://wiki.koha-community.org/wiki/Koha_on_Debian#Set_up_Apache
    a2enmod cgi rewrite
    service apache2 restart

    # https://wiki.koha-community.org/wiki/Koha_on_Debian#Configure_the_defaults
    envsubst < /provision/templates/koha-sites.conf > /etc/koha/koha-sites.conf

    # https://wiki.koha-community.org/wiki/Koha_on_Debian#Set_up_Apache
    envsubst < /provision/templates/ports.conf > /etc/apache2/ports.conf

    # THIS IS MISSING IN THE WIKI
    service mariadb start

    # https://wiki.koha-community.org/wiki/Koha_on_Debian#Create_a_Koha_instance
    koha-create --create-db "${KOHA_INSTANCE}"

    # https://wiki.koha-community.org/wiki/Koha_on_Debian#Setup_plack
    a2enmod headers proxy_http
    service apache2 restart

    koha-plack --enable "${KOHA_INSTANCE}"
    koha-plack --start "${KOHA_INSTANCE}"
    service apache2 restart
else
    echo "Koha set-up already. Starting..."
fi

# https://wiki.koha-community.org/wiki/Koha_on_Debian#Access_the_web_interface
echo -e "\nINTRANET: http://${KOHA_INSTANCE}${KOHA_INTRANET_SUFFIX}${KOHA_DOMAIN}:${KOHA_INTRANET_PORT}"
echo "OPAC: http://${KOHA_INSTANCE}${KOHA_DOMAIN}:${KOHA_OPAC_PORT}"
echo -e "Koha user:"
xmlstarlet sel -t -v '/yazgfs/config/user' /etc/koha/sites/${KOHA_INSTANCE}/koha-conf.xml
echo -e "\nKoha password:"
xmlstarlet sel -t -v '/yazgfs/config/pass' /etc/koha/sites/${KOHA_INSTANCE}/koha-conf.xml
echo -e "\n"

# Keep the Docker container outputting any relevant log
tail -f \
    /var/log/apache2/access.log \
    /var/log/apache2/error.log \
    /var/log/koha/${KOHA_INSTANCE}/*error.log