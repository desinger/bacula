echo "Waiting for mysql"
until mysql --host=$DB_HOST --port=3306 --user=$DB_USER --password=$DB_PASS &> /dev/null
do
  printf "."
  sleep 1
done

echo -e "\nmysql ready"

mkdir -p /bacula/backup /bacula/restore
chown -R bacula:bacula /bacula
chmod -R 700 /bacula
sed -i -e "s/^.*mailhub=.*$/mailhub=$SMTP_SERVER/" /etc/ssmtp/ssmtp.conf
sed -i -e "s/^.*/$DOMAINNAME/" /etc/mailname
RESULT=`mysqlshow --host=$DB_HOST --user=$DB_USER --password=$DB_PASS bacula| grep -v Wildcard | grep -o bacula`
if [ "$RESULT" == "bacula" ]; then
    echo "==>Database already created"
else
create_mysql_database --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
make_mysql_tables --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
grant_mysql_privileges --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
echo "==> Creating database setup"
fi

echo "==> Starting Bacula SD"
bacula-sd -c /etc/bacula/bacula-sd.conf &
echo "==> Bacula SD is started"
echo "==> Starting Bacula DIR" 
bacula-dir -c /etc/bacula/bacula-dir.conf -d 50 -f # -d /debug level/

#echo "==> Bacula DIR is started"

