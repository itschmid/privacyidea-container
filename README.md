# PrivacyIdea Container Image


[privacyIDEA](https://www.privacyidea.org/) is a modular authentication server that can be used to enhance the security of your existing applications like local login, VPN, remote access, SSH connections, access to web sites or web portals with two factor authentication. Originally it was used for OTP (One Time Password) authentication devices – being an OTP server. But other “devices” like challenge response, U2F, Yubikeys, SSH keys and x509 certificates are also available. It runs on Linux and is completely Open Source, licensed under the AGPLv3.

This repository contains the blueprint to build your own PrivacyIdea container. Additionally, there is a docker-compose.yml file for running such a container with Mariadb.

## Preparing

First, we create an .env file with the following content.
The data can also be written directly to the Docker Compose file, the better variant is .env

	PI_MYSQL_ROOT_PASSWORD=<mariadb root password>
	PI_MYSQL_PASSWORD=<password for privacycidea database>
	PI_MYSQL_USER=<username for privacyidea database>
	PI_ADMIN_USER=<privacyidea username for first admin>
	PI_ADMIN_PASSWORD=<privacyidea admin password>
	PI_SUPERUSER_REALM=<optional superuser realm, e.g "tech, mega">
	PI_DBDRIVER=<database drivername, pymsql or sqlite>

## Get started

First you need to build the Docker image, run:

	docker build -t privacyidea .

Now when docker-compose is used, run:

	docker-compose up -d

Next, a Mariadb container is deployed. The PrivacyIdea container is then started as soon as the database container is ready.

Now you can access the Privacyidea website via http://docker:5001 and log in with the password and username entered in the .env.

## Documentation

How to set up privacyidea can be found in the official [documentation](https://privacyidea.readthedocs.io/en/latest/) of [PrivacyIDEA](https://www.privacyidea.org/)


## License

This repository, i.e. the building instructions for the container, is under MIT License.

