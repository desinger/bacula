mysqld --initialize-insecure #init mysql with root user no password

service mysql start

mysql -u root --skip-password #login root user

ALTER USER 'root'@'localhost' IDENTIFIED BY '1'; #change root user password with "1"

GRANT ALL ON *.* to root@'%' IDENTIFIED BY '1'; #grand privileges to user to acces databases

