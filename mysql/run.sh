if [[ ! -z "`mysql -qfsBe "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='bacula'" 2>&1`" ]];
then
  echo "DATABASE ALREADY EXISTS"
else
  echo "DATABASE DOES NOT EXIST"
mysqld --initialize-insecure
service mysql start
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1' ;" -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY '1';"
/bin/bash
echo "==> Creating database setup"
fi

service mysql start && /bin/bash

