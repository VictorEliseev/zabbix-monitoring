#!/bin/sh
# Запуск ротації логів всередині контейнера проксі
/usr/sbin/logrotate /etc/logrotate.d/zabbix-traps
