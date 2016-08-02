mysqld --initialize-insecure
service mysql start
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1' ;" -e "GRANT ALL ON *.* to root@'%' IDENTIFIED BY '1';"
/bin/bash
echo "==> Creating database setup"
#fi

service mysql start && /bin/bash

