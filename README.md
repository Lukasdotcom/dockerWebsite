# dockerWebsite
A docker container for my website

## Installation
Steps for installation
First get the .env file with:

``
wget https://raw.githubusercontent.com/Lukasdotcom/dockerWebsite/main/.env
``

Then make sure that all the variables in the .env file are the way you want them to be.
Then make a volume for the backups by running:

``
docker volume create backup
``

Then run the following command to start the container and then it should be accessable at port 80.

``
docker run --privileged -d -p 80:80 --name website --env-file .env --volume=/var/run/docker.sock:/var/run/docker.sock --volume=backup:/backup lukasdotcom/website
``

When you are done I would recommend for you to login and update the server in the web portal.
## Email
You can send emails through any smtp server and then just put the credentials in the enviromental file.
## Advanced
If you want ssl you can expose port 443 also and use apache certbot to enable ssl on the website.
