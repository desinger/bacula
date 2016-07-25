
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

# Now start both the FD and the DIR forcing them into the background while
# still using -f. This way we can run both commands simultaniously in the
# foreground.
#echo "==> Starting Bacula FD"
#/opt/bacula/bin/bacula-fd -c /opt/bacula/etc/bacula-fd.conf -d ${BACULA_DEBUG} -f &

echo "==> Starting Bacula DIR"
bacula-sd -c /etc/bacula/bacula-sd.conf 
bacula-fd -c /etc/bacula/bacula-fd.conf 
bacula-dir -f -c /etc/bacula/bacula-dir.conf 
#bacula start
#bconsole

echo "==> Bacula DIR is started"

