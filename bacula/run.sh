echo "Waiting for mysql"
until mysql -h"mysql" -P"3306" -uroot -p"1" &> /dev/null
do
  printf "."
  sleep 1
done

echo -e "\nmysql ready"

#: ${DB_USER:="root"}
#: ${DB_HOST:="mysql"}
#: ${DB_NAME:="bacula"}
#: ${DB_PASS:="1"}

mkdir -p /bacula/backup /bacula/restore
chown -R bacula:bacula /bacula
chmod -R 700 /bacula

RESULT=`mysqlshow --host=mysql --user=root --password=1 bacula| grep -v Wildcard | grep -o bacula`
if [ "$RESULT" == "bacula" ]; then
    echo "==>Database already created"
else
create_mysql_database --host=mysql --user=root --password=1
make_mysql_tables --host=mysql --user=root --password=1
grant_mysql_privileges --host=mysql --user=root --password=1
echo "==> Creating database setup"
fi

echo "==> Starting Bacula SD"
bacula-sd -c /etc/bacula/bacula-sd.conf &
echo "==> Bacula SD is started"
echo "==> Starting Bacula DIR" 
bacula-dir -c /etc/bacula/bacula-dir.conf -d 100 -f # -d /debug level/

#echo "==> Bacula DIR is started"
#bconsole

