cd /etc/bacula
create_sqlite3_database 
make_bacula_tables 
grant_sqlite3_privileges

bacula start

