echo "Waiting for mysql"
until mysql --host=$DB_HOST --port=3306 --user=$DB_USER --password=$DB_PASS &> /dev/null
do
  printf "."
  sleep 1
done
#bacula-dir
sed -i -e "s/^.*BS_PASS/$BS_PASS/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*DB_NAME/$DB_NAME/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*DB_USER/$DB_USER/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*DB_PASS/$DB_PASS/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*DB_HOST/$DB_HOST/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*BMON_PASS/$BMON_PASS/" /etc/bacula/bacula-dir.conf
sed -i -e "s/^.*MAIL_ON_ERROR/$MAIL_ON_ERROR/" /etc/bacula/bacula-dir.conf


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
#bconsole



