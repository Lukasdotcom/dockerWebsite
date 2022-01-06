FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Detroit
# Used to install all the required software
RUN apt update
RUN apt upgrade -y
RUN apt install -y apache2
RUN apt install -y mariadb-server
RUN apt install -y php
RUN apt install -y php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip
RUN apt install -y python3
RUN apt install -y pip
RUN apt install -y git
RUN apt install -y unattended-upgrades
RUN python3 -m pip install mysql-connector-python
RUN python3 -m pip install RPi.GPIO
RUN apt install -y nano
# Clones the website
WORKDIR "/var/www"
RUN rm -r html
RUN git clone https://github.com/lukasdotcom/website
# Gets the startup script ready
COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]
# Gives apache the right settings
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf
RUN a2enmod rewrite
# Gives the website default configurations
COPY python.json /var/www/website/python/config.json
CMD ["/scripts/start.sh"]
# Sets all the default enviromental vars
ENV WEBSITE_API none
ENV WEBSITE_USER admin
ENV WEBSITE_DATABASE_TABLE website
ENV WEBSITE_PASSWORD password
ENV WEBSITE_BACKUP_LOCATION /backup
ENV WEBSITE_BACKUP_LENGTH 604800
ENV WEBSITE_DEVELOPER true
ENV WEBSITE_THROTTLE 5
ENV WEBSITE_THROTTLE_TIME 30
ENV WEBSITE_FAN_START 43
ENV WEBSITE_FAN_STOP 35

EXPOSE 443
EXPOSE 80