
#RESULT=`mysqlshow --host=mysql --user=root --password=1 bacula| grep -v Wildcard | grep -o bacula`
#if [ "$RESULT" == "bacula" ]; then
#    echo "==>Database already created"
#else
mysqld --initialize-insecure
service mysql start

mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1' ;" -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY '1';"
/bin/bash
echo "==> Creating database setup"
#fi

service mysql start && /bin/bash

