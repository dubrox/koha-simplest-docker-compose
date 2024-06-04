FROM debian:bookworm

LABEL maintainer="dubrox@dubrox.com"

# https://wiki.koha-community.org/wiki/Koha_on_Debian#Set_up_package_sources
RUN apt update \
    && apt install -y \
        apache2 \
        apt-transport-https \
        gnupg2 \
        mariadb-server \
        supervisor \
        wget \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*
    
RUN wget -qO - https://debian.koha-community.org/koha/gpg.asc | gpg --dearmor -o /usr/share/keyrings/koha-keyring.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/koha-keyring.gpg] https://debian.koha-community.org/koha 23.05 main' | tee /etc/apt/sources.list.d/koha.list \
    && apt update \
    && apt install -y \
        koha-common \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

ADD ./templates/koha-sites.conf /provision/templates/koha-sites.conf
ADD ./templates/ports.conf /provision/templates/ports.conf
ADD --chmod=0700 ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]