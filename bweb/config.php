
<?php
// Language
$config['language'] = 'en_US';
 
// Show inactive clients
$config['show_inactive_clients'] = false;
 
// Hide empty pools
$config['hide_empty_pools'] = true;

//MySQL bacula catalog
$config[0]['label'] = 'Backup Server';
$config[0]['host'] = '192.168.2.119';
$config[0]['login'] = 'root';
$config[0]['password'] = '1';
$config[0]['db_name'] = 'bacula';
$config[0]['db_type'] = 'mysql';
$config[0]['db_port'] = '3306'; 
// SQLite bacula catalog
//$config[0]['host'] = '192.168.2.119';
//$config[0]['db_type'] = 'sqlite';
//$config[0]['label'] = 'rufus-dir';
//$config[0]['db_name'] = '/opt/bacula/working/bacula.db';
?>
