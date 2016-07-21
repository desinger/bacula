
#if sqlite3 /etc/bacula/bacula.db "SELECT EXISTS (SELECT * FROM PATH WHERE type='table' AND name='<tableName>')";then
#    echo "=> Database already setup; skipping."

echo "==> Creating database setup"
    /etc/bacula/create_sqlite3_database 
    /etc/bacula/make_sqlite3_tables 
    /etc/bacula/grant_sqlite3_privileges
   
# Now start both the FD and the DIR forcing them into the background while
# still using -f. This way we can run both commands simultaniously in the
# foreground.
#echo "==> Starting Bacula FD"
#/opt/bacula/bin/bacula-fd -c /opt/bacula/etc/bacula-fd.conf -d ${BACULA_DEBUG} -f &

echo "==> Starting Bacula DIR"
#bacula-sd -f -c /etc/bacula/bacula-sd.conf
#bacula-fd -f -c /etc/bacula/bacula-fd.conf
#bacula-dir -f -c /etc/bacula/bacula-dir.conf
bacula start
bconsole
bash