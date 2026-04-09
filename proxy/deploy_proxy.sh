#!/bin/bash

# Цвета
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Запуск развертывания Zabbix Infrastructure (Proxy + Agent)...${NC}"

# 1. Проверка .env
if [ ! -f .env ]; then
    echo -e "${RED}Ошибка: Файл .env не найден!${NC}"
    echo -e "Создайте .env на основе .env.example перед запуском."
    exit 1
fi

# 2. Создание структуры папок (согласно путям в .env)
echo -e "${YELLOW}Подготовка локальных директорий для данных...${NC}"
# Подтягиваем пути из .env или используем дефолты
mkdir -p ./zabbix_db
mkdir -p ./snmptraps
mkdir -p ./tailscale_state
mkdir -p ./mibs/iana
mkdir -p ./mibs/ietf

# 3. Настройка прав
echo -e "${YELLOW}Настройка прав доступа...${NC}"
# Права на базу и трапы (контейнеры Zabbix работают от разных UID)
chmod -R 777 ./zabbix_db ./snmptraps ./tailscale_state
# Права на исполнение всех скриптов в текущей папке
chmod +x *.sh

# 4. Проверка конфига
SERVER_IP=$(grep ZBX_SERVER_IP .env | cut -d '=' -f2)
PROXY_NAME=$(grep PROXY_HOSTNAME .env | cut -d '=' -f2)

echo -e "${YELLOW}Конфигурация:${NC}"
echo -e " - Proxy Name: ${GREEN}$PROXY_NAME${NC}"
echo -e " - Server IP:  ${GREEN}$SERVER_IP${NC}"

# 5. Проверка связи (опционально)
if [ ! -z "$SERVER_IP" ]; then
    echo -e "${YELLOW}Проверка маршрута к серверу...${NC}"
    # Если Tailscale уже запущен на хосте — пинг пройдет. 
    # Если только в докере — пинг заработает после поднятия контейнеров.
    if ping -c 1 -W 2 "$SERVER_IP" &> /dev/null; then
        echo -e "${GREEN}Сервер мониторинга доступен через туннель.${NC}"
    else
        echo -e "${RED}Подсказка: Если сервер не пингуется, проверьте статус Tailscale после запуска контейнеров.${NC}"
    fi
fi

# 6. Запуск
echo -e "${YELLOW}Запуск Docker контейнеров...${NC}"
docker compose pull # Обновим образы перед запуском
docker compose up -d

echo -e "-------------------------------------------------------"
echo -e "${GREEN}Развертывание завершено!${NC}"
echo -e "Чтобы увидеть статус туннеля: ${YELLOW}docker exec ts-gateway tailscale status${NC}"
echo -e "Чтобы увидеть логи агента:    ${YELLOW}docker logs -f zabbix-agent-tailscale${NC}"
echo -e "-------------------------------------------------------"