FROM ubuntu:kinetic-20220830
ARG TARGETPLATFORM
ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Detroit
# Used to install all the required software
RUN apt update
RUN apt upgrade -y
RUN apt install -y apache2 --no-install-recommends
RUN apt install -y mariadb-server
RUN apt install -y php --no-install-recommends
RUN apt install -y php-json php-mysql php-curl php-zip --no-install-recommends
RUN apt install -y python3 --no-install-recommends
RUN apt install -y git --no-install-recommends
RUN apt install -y python3-mysql.connector --no-install-recommends
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ] || [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then apt install -y python3-rpi.gpio; fi
RUN apt install -y python3-requests --no-install-recommends
RUN apt install -y python3-docker --no-install-recommends
RUN apt install -y composer --no-install-recommends
RUN apt install -y curl --no-install-recommends
# Clones the website
WORKDIR "/var/www"
RUN rm -r html
RUN git clone https://github.com/lukasdotcom/website
# Makes sure to auto restore the latest backup in the volume
COPY restore.json /var/www/website/html/restore.json
COPY update.sh /var/www/website/python/update.sh
RUN ["chmod", "+x", "/var/www/website/python/update.sh"]
# Gets the startup script ready
COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]
# Gives apache the right settings
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf
RUN a2enmod rewrite
CMD ["/scripts/start.sh"]
# Runs composer to install all dependencies
WORKDIR "/var/www/website/html"
RUN composer install
# Adds a healthcheck
HEALTHCHECK --timeout=5s CMD curl --fail http://localhost || exit 1
# Sets all the default enviromental variables
ENV WEBSITE_API none
ENV MAIL_SMTP_SERVER none
ENV MAIL_USERNAME none
ENV MAIL_PASSWORD none
ENV MAIL_SMTP_PORT 587
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

EXPOSE 80