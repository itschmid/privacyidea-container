# PrivacyIdea Container Image


[privacyIDEA](https://www.privacyidea.org/) is a modular authentication server that can be used to enhance the security of your existing applications like local login, VPN, remote access, SSH connections, access to web sites or web portals with two factor authentication. Originally it was used for OTP (One Time Password) authentication devices – being an OTP server. But other “devices” like challenge response, U2F, Yubikeys, SSH keys and x509 certificates are also available. It runs on Linux and is completely Open Source, licensed under the AGPLv3.

This repository contains the blueprint to build your own privacyIDEA container. Additionally, there is a docker-compose.yml file for running such a container with Mariadb.

## Preparing

First, we create an .env file with the following content.
The data can also be written directly to the Docker Compose file, the better variant is .env

	MYSQL_ROOT_PASSWORD=<mariadb root password>
	PI_DB_PASS=<password for privacycidea database>
	PI_DB_USER=<username for privacyidea database>
	PI_DB_HOST=<database hostname / ip>
	PI_DB_NAME=<databasename>
	PI_ADMIN_USER=<privacyidea username for first admin>
	PI_ADMIN_PASSWORD=<privacyidea admin password>
	PI_SUPERUSER_REALM=<optional superuser realm, e.g "tech, mega">
	PI_DBDRIVER=<database drivername, pymsql or sqlite>

## Get started

First you need to build the Docker image, run:

	docker build -t privacyidea .

Now, when docker-compose is used, run:

	docker-compose up -d

Next, a Mariadb container is deployed. The privacyIDEA container is then started as soon as the database container is ready.

Now you can access the privacyIDEA website via http://docker:5001 and log in with the password and username entered in the .env.

## Documentation

How to set up privacyIDEA can be found in the official [documentation](https://privacyidea.readthedocs.io/en/latest/) of [privacyIDEA](https://www.privacyidea.org/)


## License

This repository, i.e. the building instructions for the container, is under [MIT License](LICENSE).

