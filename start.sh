#!/bin/bash
service apache2 start
service mariadb start
python3 /var/www/website/python/restart.py