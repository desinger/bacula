cp -R /tmp/lib/ /usr/
chown www-data:www-data /usr/share/baculum/htdocs/protected/Data/settings.conf
chmod 700 /usr/share/baculum/htdocs/protected/Data/settings.conf
service apache2 start 
bash

