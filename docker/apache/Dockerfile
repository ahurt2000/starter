FROM debian:latest

# RUN usermod --non-unique --uid 1000 www-data
# RUN groupmod --non-unique --gid 1000 www-data

RUN apt-get update \
    && apt-get -y install apt-utils apache2

RUN rm /etc/apache2/sites-enabled/*

ENV VIRTUALHOST localhost

ADD conf-available /etc/apache2/conf-available
ADD ssl-cert/ssl-cert-snakeoil.pem /etc/apache2/ssl/apache.pem
ADD ssl-cert/ssl-cert-snakeoil.key /etc/apache2/ssl/apache.key
#ADD mods-available /etc/apache2/mods-available

ADD apache.sh /usr/bin/apache.sh
RUN chmod +x /usr/bin/apache.sh
ENTRYPOINT apache.sh