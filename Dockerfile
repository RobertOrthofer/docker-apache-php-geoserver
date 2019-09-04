FROM php:7.3-apache-stretch

# module to handle http proxy requests
# needs restart after adding new modules
RUN apt-get update && apt-get -y install build-essential && \
    a2enmod proxy proxy_http

RUN echo "ProxyPass /geoserver http://geoserver:8080/geoserver" > /etc/apache2/conf-available/proxy.conf
RUN echo "ProxyPassReverse /geoserver http://geoserver:8080/geoserver" >> /etc/apache2/conf-available/proxy.conf
RUN ln -s /etc/apache2/conf-available/proxy.conf /etc/apache2/conf-enabled/proxy.conf

# to see all loaded modules:
# docker-compose exec php_apache /bin/bash
# apache2ctl -M