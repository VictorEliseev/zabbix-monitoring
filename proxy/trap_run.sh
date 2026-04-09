#!/bin/sh
apk add --no-cache net-snmp sed

mkdir -p /var/lib/zabbix/snmptraps
chmod 777 /var/lib/zabbix/snmptraps/snmptraps.log

# Спрощуємо формат виводу snmptrapd, щоб sed було простіше
# Ми беремо лише дані (%v) та адресу відправника (%b)
snmptrapd -n -f -C -c /dev/null -L o --disableAuthorization=yes \
--format1='%v IP: %b\n' \
--format2='%v IP: %b\n' | sed -u 'h; s/.*IpAddress: \([0-9.]*\).*/ZBXTRAP \1/p; g' >> /var/lib/zabbix/snmptraps/snmptraps.log 2>&1
