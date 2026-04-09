#!/bin/sh
# --- LOG ROTATION TRIGGER / ЗАПУСК РОТАЦІЇ ЛОГІВ ---

# Explicitly run logrotate using the specific Zabbix traps configuration
# Примусово запускаємо logrotate, використовуючи специфічний конфіг для трапів Zabbix
/usr/sbin/logrotate /etc/logrotate.d/zabbix-traps