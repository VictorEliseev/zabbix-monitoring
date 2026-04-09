#!/bin/sh
# --- SNMP TRAP COLLECTOR ENGINE / ДВИГУН КОЛЕКТОРА SNMP-ТРАПІВ ---

# Install necessary packages (net-snmp for trap daemon, sed for stream processing)
# Встановлюємо необхідні пакети (net-snmp для демона трапів, sed для обробки потоку)
apk add --no-cache net-snmp sed

# Ensure the log directory exists and the log file is writable
# Переконуємося, що директорія логів існує, а файл доступний для запису
mkdir -p /var/lib/zabbix/snmptraps
touch /var/lib/zabbix/snmptraps/snmptraps.log
chmod 777 /var/lib/zabbix/snmptraps/snmptraps.log

# Launch snmptrapd and pipe output to sed for Zabbix-compatible formatting
# Запускаємо snmptrapd та передаємо вивід у sed для форматування під Zabbix
#
# Logic:
# 1. snmptrapd captures the trap and formats it as '%v IP: %b'
# 2. sed identifies the sender's IP and prepends 'ZBXTRAP' (required by Zabbix)
# 
# Логіка:
# 1. snmptrapd перехоплює трап і формує рядок '%v IP: %b'
# 2. sed знаходить IP відправника і додає префікс 'ZBXTRAP' (вимога Zabbix)

snmptrapd -n -f -C -c /dev/null -L o --disableAuthorization=yes \
--format1='%v IP: %b\n' \
--format2='%v IP: %b\n' | \
sed -u 'h; s/.*IpAddress: \([0-9.]*\).*/ZBXTRAP \1/p; g' >> /var/lib/zabbix/snmptraps/snmptraps.log 2>&1