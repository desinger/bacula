cp -R /tmp/lib/ /usr/
chown www-data:www-data /usr/share/baculum/htdocs/protected/Data/settings.conf
chmod 700 /usr/share/baculum/htdocs/protected/Data/settings.conf

chown www-data:www-data /etc/baculum/Data-apache/settings.conf
chmod 700 /etc/baculum/Data-apache/settings.conf



sed -i '/Global/a ServerName www.bacula.com:80' /etc/apache2/apache2.conf 

sed -i "s/"DB_NAME"/"$DB_NAME"/" /usr/share/baculum/htdocs/protected/Data/settings.conf
sed -i "s/"DB_USER"/"$DB_USER"/" /usr/share/baculum/htdocs/protected/Data/settings.conf
sed -i "s/"DB_PASS"/"$DB_PASS"/" /usr/share/baculum/htdocs/protected/Data/settings.conf
sed -i "s/"DB_HOST"/"$DB_HOST"/" /usr/share/baculum/htdocs/protected/Data/settings.conf

sed -i "s/"BWEB_USER"/"$BWEB_USER"/" /usr/share/baculum/htdocs/protected/Data/settings.conf
sed -i "s/"BWEB_PASS"/"$BWEB_PASS"/" /usr/share/baculum/htdocs/protected/Data/settings.conf

cp -rf /usr/share/baculum/htdocs/protected/Data/settings.conf /etc/baculum/Data-apache/settings.conf


#service apache2 start
#bash

/usr/sbin/apachectl  -f /etc/apache2/apache2.conf -DFOREGROUND
