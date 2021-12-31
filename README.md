# dockerWebsite
A docker container for my website

## Installation

You should build the container yourself right now otherwise the config will be wrong. But before you do that edit the config file to your liking.

``
docker build -t lukasdotcom/website .
``

After either downloading the container or building it you can run the container with this command and then the website is complete. Use admin and password for the admin credentials on the website.

``
docker run --privilged -d -p 80:80 -p 433:433 lukasdotcom/website
``

When you are done I would recommend for you to login and update the server in the web portal.
