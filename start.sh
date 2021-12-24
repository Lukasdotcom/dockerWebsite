#!/bin/bash
service apache2 start
service mysql start
python3 /var/www/website/python/restart.py