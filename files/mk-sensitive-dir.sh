#!/bin/sh
# file /usr/local/sbin/mk-sensitive-dir.sh
umask 0077

for D in `awk -F':' '{if ($3>999 && $3<10000) print $1}' /etc/passwd`; do
	mkdir -p -m 0700 /run/secrets-${D}
	touch /run/secrets-${D}/MYSQL_USER /run/secrets-${D}/MYSQL_PASSWORD /run/secrets-${D}/MYSQL_DATABASE
	chown -R ${D}:0 /run/secrets-${D}
done
[ -x /root/bin/dp-secrets.sh ] && /root/bin/dp-secrets.sh
exit 0
