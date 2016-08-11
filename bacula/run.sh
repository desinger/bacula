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
#edit bacula-dir.conf
#cp /etc/bacula/bacula-dir.conf /tmp
#cp /etc/bacula/bacula-sd.conf /tmp
sed -i -e "s/BS_PASS/$BS_PASS/" /tmp/bacula-dir.conf
sed -i -e "s/DB_NAME/$DB_NAME/" /tmp/bacula-dir.conf
sed -i -e "s/DB_USER/$DB_USER/" /tmp/bacula-dir.conf
sed -i -e "s/DB_PASS/$DB_PASS/" /tmp/bacula-dir.conf
sed -i -e "s/DB_HOST/$DB_HOST/" /tmp/bacula-dir.conf
sed -i -e "s/BMON_PASS/$BMON_PASS/" /tmp/bacula-dir.conf
sed -i -e "s/MAIL_ON_ERROR/$MAIL_ON_ERROR/" /tmp/bacula-dir.conf
sed -i -e "s/CLI_PASS/$CLI_PASS/" /tmp/bacula-dir.conf
sed -i -e "s/CLI_NAME1/$CLI_NAME1/" /tmp/bacula-dir.conf
sed -i -e "s/CLI_NAME2/$CLI_NAME2/" /tmp/bacula-dir.conf
sed -i -e "s/CLI_ADDR1/$CLI_ADDR1/" /tmp/bacula-dir.conf
sed -i -e "s/CLI_ADDR2/$CLI_ADDR2/" /tmp/bacula-dir.conf
sed -i -e "s/DIR_PASS/$DIR_PASS/" /tmp/bacula-dir.conf
sed -i -e "s/DIR_PASS/$DIR_PASS/" /tmp/bacula-sd.conf

cp /tmp/bacula-dir.conf /etc/bacula
cp /tmp/bacula-sd.conf /etc/bacula
#ssmtp ako se mahne ne trqbva toq red
sed -i -e "s/^.*/$DOMAINNAME/" /etc/mailname
RESULT=`mysqlshow --host=$DB_HOST --user=$DB_USER --password=$DB_PASS bacula| grep -v Wildcard | grep -o bacula`
if [ "$RESULT" == "bacula" ]; then
    echo "==>Database already created"
else
/etc/bacula/create_mysql_database --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
/etc/bacula/make_mysql_tables --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
/etc/bacula/grant_mysql_privileges --host=$DB_HOST --user=$DB_USER --password=$DB_PASS
echo "==> Creating database setup"
fi

echo "==> Starting Bacula SD"
bacula-sd -c /etc/bacula/bacula-sd.conf &
echo "==> Bacula SD is started"
echo "==> Starting Bacula DIR" 
bacula-dir -c /etc/bacula/bacula-dir.conf -d 5 -f # -d /debug level/

echo "==> Bacula DIR is started"

