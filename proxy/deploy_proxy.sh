#!/bin/bash

# Цвета
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Запуск развертывания Zabbix Proxy...${NC}"

# 1. Проверка .env
if [ ! -f .env ]; then
    echo -e "${RED}Ошибка: Файл .env не найден!${NC}"
    echo -e "Скопируйте конфиг из приватного репозитория перед запуском."
    exit 1
fi

# 2. Создание структуры (база, конфиги, скрипты)
echo -e "${YELLOW}Подготовка локальных директорий...${NC}"
mkdir -p zabbix_proxy_db
mkdir -p snmp/mibs
mkdir -p scripts

# 3. Настройка прав
echo -e "${YELLOW}Настройка прав доступа...${NC}"
# Права на базу данных для контейнера
chmod -R 777 zabbix_proxy_db 
# Права на исполнение скриптов (те самые .sh из репозитория)
chmod +x *.sh

# 4. Проверка связи с основным сервером (если IP указан в .env)
SERVER_IP=$(grep ZBX_SERVER_HOST .env | cut -d '=' -f2)
if [ ! -z "$SERVER_IP" ]; then
    echo -e "${YELLOW}Проверка связи с сервером ($SERVER_IP)...${NC}"
    if ping -c 2 "$SERVER_IP" &> /dev/null; then
        echo -e "${GREEN}Сервер доступен.${NC}"
    else
        echo -e "${RED}ВНИМАНИЕ: Сервер $SERVER_IP не отвечает. Проверьте Tailscale/VPN!${NC}"
    fi
fi

# 5. Запуск
echo -e "${GREEN}Запуск контейнеров прокси...${NC}"
docker compose up -d

echo -e "${GREEN}Готово! Проверьте логи: ${YELLOW}docker compose logs -f${NC}"