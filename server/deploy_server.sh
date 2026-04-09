#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Начало развертывания Zabbix Server...${NC}"

# 1. Проверка наличия .env файла
if [ ! -f .env ]; then
    echo -e "${RED}Ошибка: Файл .env не найден!${NC}"
    echo -e "Пожалуйста, создайте его из .env.example и заполните данными из приватного репозитория."
    exit 1
fi

# 2. Создание структуры папок для данных (которые игнорируются гитом)
echo -e "${YELLOW}Создание директорий для данных...${NC}"
mkdir -p postgres/data
mkdir -p zabbix/db
mkdir -p zabbix/alertscripts
mkdir -p nginx-proxy/data
mkdir -p nginx-proxy/letsencrypt

# 3. Установка прав (опционально, но полезно)
echo -e "${YELLOW}Настройка прав доступа...${NC}"
chmod -R 755 zabbix/alertscripts
# Если есть другие скрипты в корне
chmod +x *.sh 2>/dev/null

# 4. Проверка Docker и Docker Compose
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker не установлен. Пожалуйста, установите Docker перед запуском.${NC}"
    exit 1
fi

# 5. Запуск контейнеров
echo -e "${GREEN}Все готово! Запускаю контейнеры...${NC}"
docker compose up -d

echo -e "${GREEN}Развертывание завершено успешно!${NC}"
echo -e "Проверьте статус: ${YELLOW}docker compose ps${NC}"