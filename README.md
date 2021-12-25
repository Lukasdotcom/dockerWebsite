# dockerWebsite
A docker container for my website

## Installation
If you are running this on an linux/arm64 system you can use:

``
docker pull lukasdotcom/website
``

If you do not have a linux/arm64 system you can build the container with these commands after downloading this repository.

``
docker build -t lukasdotcom/website .
``

After either downloading the container or building it you can run the container with this command and then the website is complete. Use default and password for the admin credentials on the website.

``
docker run --privilged -d -p 80:80 -p 433:433 lukasdotcom/website
``

When you are done I would recommend for you to login and update the server in the web portal.
