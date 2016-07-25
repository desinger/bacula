
mkdir -p /bacula/backup /bacula/restore
chown -R bacula:bacula /bacula
chmod -R 700 /bacula
#if sqlite3 /etc/bacula/bacula.db "SELECT EXISTS (SELECT * FROM PATH WHERE type='table' AND name='<tableName>')";then
#    echo "=> Database already setup; skipping."
echo "==> Creating database setup"
    #/etc/bacula/create_sqlite3_database 
    /etc/bacula/make_mysql_tables 
    /etc/bacula/grant_mysql_privileges
   
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

