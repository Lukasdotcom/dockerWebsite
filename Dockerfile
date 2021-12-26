FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
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
RUN python3 -m pip install mysql-connector-python
RUN python3 -m pip install RPi.GPIO
RUN apt install -y python3-certbot-apache
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
# Gives the website default configurations
COPY python.json /var/www/website/python/config.json
COPY html.json /var/www/website/html/config.json
CMD ["/scripts/start.sh"]
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 443
EXPOSE 80