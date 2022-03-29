#!/bin/sh
echo "Init"

IFS=','
ERG=""
if [ -z "$PI_SUPERUSER_REALM" ]; then
	ERG="SUPERUSER_REALM = ['super', 'administrators']"
else
	for i in `echo "$PI_SUPERUSER_REALM"`;
	do
        	ERG="$ERG '$i', ";
	done
	ERG="SUPERUSER_REALM = ['super', 'administrators', $ERG]"
fi

echo "Check if pi.cfg exists"
if [ ! -e /etc/privacyidea/pi.cfg ]
then
    echo "$ERG"
    echo "$ERG" >> /etc/privacyidea/pi.cfg

    if [ -z "$PI_SCRIPT_HANDLER_DIRECTORY" ]; then
	    echo "PI_SCRIPT_HANDLER_DIRECTORY = '/scripts'" >> /etc/privacyidea/pi.cfg
    else
	    echo "script handler directory was changed to $PI_SCRIPT_HANDLER_DIRECTORY"
	    echo "PI_SCRIPT_HANDLER_DIRECTORY = $PI_SCRIPT_HANDLER_DIRECTORY" >> /etc/privacyidea/pi.cfg
    fi

    echo "DBDRIVER ===> $PI_DBDRIVER"    

    if [ "$PI_DBDRIVER" = "sqlite" ]; then
      echo "Create SQLITE"	   
      echo "SQLALCHEMY_DATABASE_URI = 'sqlite:////data/privacyidea.sqlite'" 
      echo "SQLALCHEMY_DATABASE_URI = 'sqlite:////data/privacyidea.sqlite'" >> /etc/privacyidea/pi.cfg
    else

      if [ "$PI_DBDRIVER" = "pymysql" ]; then
	echo "Create MYSQL"
	echo "SQLALCHEMY_DATABASE_URI = 'pymysql://$PI_DB_USER:$PI_DB_PASS@$PI_DB_HOST/$PI_DB_NAME'"
        echo "SQLALCHEMY_DATABASE_URI = 'pymysql://$PI_DB_USER:$PI_DB_PASS@$PI_DB_HOST/$PI_DB_NAME'" >> /etc/privacyidea/pi.cfg
      fi
    fi

    PEPPER="$(tr -dc A-Za-z0-9_ </dev/urandom | head -c24)"
    echo "PI_PEPPER = '$PEPPER'" >> /etc/privacyidea/pi.cfg

    SECRET="$(tr -dc A-Za-z0-9_ </dev/urandom | head -c24)"
    echo "SECRET_KEY = '$SECRET'" >> /etc/privacyidea/pi.cfg

    echo "PI_ENCFILE = '/etc/privacyidea/enckey'" >> /etc/privacyidea/pi.cfg
    echo "PI_AUDIT_KEY_PRIVATE = '/data/private.pem'" >> /etc/privacyidea/pi.cfg
    echo "PI_AUDIT_KEY_PUBLIC = '/data/public.pem'" >> /etc/privacyidea/pi.cfg
fi

echo "Check if enkey exists"
if [ ! -e /etc/privacyidea/enckey ]
then
  pi-manage create_enckey
  pi-manage create_audit_keys
  pi-manage createdb
  pi-manage admin add $ADMIN_USER -p $ADMIN_PASSWORD
fi
echo "Start PI Server"
#pi-manage runserver --port 5001 --host 0.0.0.0
uwsgi --ini pi-uwsgi.ini 
