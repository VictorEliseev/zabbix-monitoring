#!/bin/bash
# --- DEPLOYMENT SCRIPT / СКРИПТ РОЗГОРТАННЯ ---

# Colors for output / Кольори для виводу
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Starting Zabbix Infrastructure deployment... / Запуск розгортання інфраструктури Zabbix...${NC}"

# 1. Check for .env file / Перевірка наявності файлу .env
if [ ! -f .env ]; then
    echo -e "${RED}Error: .env file not found! / Помилка: файл .env не знайдено!${NC}"
    exit 1
fi

# 2. Create directory structure / Створення структури папок
echo -e "${YELLOW}Preparing local directories... / Підготовка локальних директорій...${NC}"
mkdir -p ./zabbix_db ./snmptraps ./tailscale_state ./mibs/iana ./mibs/ietf

# 3. Set permissions / Налаштування прав доступу
# Using 777 because Zabbix containers use different internal UIDs
# Використовуємо 777, оскільки контейнери Zabbix використовують різні внутрішні UID
echo -e "${YELLOW}Setting permissions... / Налаштування прав доступу...${NC}"
chmod -R 777 ./zabbix_db ./snmptraps ./tailscale_state
chmod +x *.sh

# 4. Extract config for verification / Витягуємо конфіг для перевірки
SERVER_IP=$(grep ZBX_SERVER_IP .env | cut -d '=' -f2)
PROXY_NAME=$(grep PROXY_HOSTNAME .env | cut -d '=' -f2)

echo -e "${YELLOW}Configuration / Конфігурація:${NC}"
echo -e " - Proxy Name: ${GREEN}$PROXY_NAME${NC}"
echo -e " - Server IP:  ${GREEN}$SERVER_IP${NC}"

# 5. Start containers / Запуск контейнерів
echo -e "${YELLOW}Launching Docker containers... / Запуск Docker контейнерів...${NC}"
docker compose pull
docker compose up -d

echo -e "-------------------------------------------------------"
echo -e "${GREEN}Deployment finished! / Розгортання завершено!${NC}"
echo -e "-------------------------------------------------------"