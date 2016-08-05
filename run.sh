: ${BACULA_DEBUG:="50"}
: ${LOG_FILE:="/var/log/bacula/bacula.log"}
: ${DIR_NAME:="bacula"}
: ${MON_NAME:="bacula"}
: ${FD_NAME:="bacula"}

# Only one variable is required, FD_PASSWORD. MON_FD_PASSWORD is derived from it.
if [ -z "${FD_PASSWORD}" ]; then
	echo "==> FD_PASSWORD must be set, exiting"
	exit 1
fi

: ${MON_FD_PASSWORD:="${FD_PASSWORD}"}

CONFIG_VARS=(
  FD_NAME
  FD_PASSWORD
  DIR_NAME
  MON_NAME
  DIR_PASS
  MON_FD_PASSWORD
)
cp /etc/bacula/bacula-dir.conf /tmp
for c in ${CONFIG_VARS[@]}; do
  sed -i "s,@@${c}@@,$(eval echo \$$c)," /tmp/bacula-dir.conf
done
