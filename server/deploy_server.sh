#!/bin/bash

# --- COLORS / КОЛЬОРИ ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Zabbix Server deployment... / Початок розгортання Zabbix Server...${NC}"

# 1. Check for .env file / Перевірка наявності .env
if [ ! -f .env ]; then
    echo -e "${RED}Error: .env file not found! / Помилка: файл .env не знайдено!${NC}"
    echo -e "Create .env from .env.example first. / Створіть .env на основі .env.example."
    exit 1
fi

# 2. Create data directories / Створення директорій для даних
# Synchronized with docker-compose.yml paths
echo -e "${YELLOW}Preparing data directories... / Підготовка директорій для даних...${NC}"
mkdir -p ./data/db
mkdir -p ./data/zbx_env/alertscripts
mkdir -p ./data/npm/data
mkdir -p ./data/npm/letsencrypt
mkdir -p ./data/tailscale

# 3. Setting permissions / Налаштування прав доступу
echo -e "${YELLOW}Setting permissions... / Налаштування прав доступу...${NC}"
# 777 for DB and Tailscale to avoid permission issues in Docker
chmod -R 777 ./data/db ./data/tailscale
chmod -R 755 ./data/zbx_env/alertscripts
chmod +x *.sh 2>/dev/null

# 4. Docker Check / Перевірка Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker is not installed! / Docker не встановлено!${NC}"
    exit 1
fi

# 5. Deployment / Запуск
echo -e "${GREEN}Everything is ready! Launching containers... / Все готово! Запуск контейнерів...${NC}"
docker compose pull
docker compose up -d

echo -e "-------------------------------------------------------"
echo -e "${GREEN}Deployment completed successfully! / Розгортання завершено успішно!${NC}"
echo -e "Check status: / Перевірити статус: ${YELLOW}docker compose ps${NC}"
echo -e "Tailscale status: / Статус Tailscale: ${YELLOW}docker exec ts-server tailscale status${NC}"
echo -e "-------------------------------------------------------"