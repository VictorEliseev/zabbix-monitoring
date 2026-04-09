Посібник із розгортання Zabbix Server (Cloud/On-Prem)
Цей посібник містить інструкції щодо розгортання центрального Zabbix Server Hub за допомогою Docker, PostgreSQL з TimescaleDB та Tailscale для безпечного зв'язку між філіями.

Огляд
Ця конфігурація включає:

Zabbix Server 7.0 (LTS): Основне ядро системи моніторингу.

PostgreSQL 16 + TimescaleDB: Високопродуктивна база даних для часових рядів (Time-series).

Tailscale: Захищений VPN-тунель для підключення віддалених проксі без відкриття публічних портів.

Nginx Proxy Manager (NPM): Реверс-проксі для SSL-сертифікатів та доступу до веб-інтерфейсу.

Zabbix Agent 2: Самомоніторинг ресурсів хост-сервера.

Попередні вимоги
Перед початком переконайтеся, що у вас є:

Docker та Docker Compose, встановлені на вашому сервері.

Ключ авторизації Tailscale: Згенеруйте багаторазовий (reusable) ключ у вашій консолі адміністрування Tailscale.

Публічна IP-адреса та домен (опціонально): Якщо ви плануєте використовувати Nginx Proxy Manager з SSL Let's Encrypt.

Етапи розгортання
1. Підготовка середовища
Перейдіть у директорію сервера:

Bash
cd server/
Створіть власний файл .env на основі наданого шаблону:

Bash
cp .env.example .env
Відредагуйте .env, вказавши надійні паролі та ваш Tailscale Auth Key.

2. Ініціалізація бази даних
Переконайтеся, що файл init_timescaledb.sql знаходиться в директорії сервера. Він містить команду для активації розширення:

SQL
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
3. Запуск скрипта розгортання
Запустіть скрипт автоматизації для підготовки папок та запуску контейнерів:

Bash
chmod +x deploy_server.sh
./deploy_server.sh
4. Перевірка зв'язку
Перевірте, чи активний тунель Tailscale, та дізнайтеся свою внутрішню IP-адресу:

Bash
docker exec ts-server tailscale status
Примітка: Використовуйте цю IP-адресу для підключення віддалених Zabbix-проксі до цього сервера.

Післяінсталяційне налаштування
Конфігурація SSL (Nginx Proxy Manager)
Відкрийте веб-інтерфейс NPM за адресою http://your-server-ip:81.

Стандартні дані для входу: admin@example.com / changeme.

Створіть Proxy Host:

Domain Names: zabbix.yourdomain.com

Forward Hostname: zabbix-web

Forward Port: 8080

Увімкніть SSL (Let's Encrypt) для безпечного доступу.

Налаштування Zabbix Web
Відкрийте ваш домен у браузері.

Дотримуйтесь вказівок майстра налаштування Zabbix.

Для підключення до БД використовуйте:

Database type: PostgreSQL

Database host: zabbix-db

User/Password: Як визначено у вашому .env.

Вирішення проблем
Помилки бази даних: Перевірте логи командою docker compose logs zabbix-db.

Проблеми Tailscale: Переконайтеся, що /dev/net/tun доступний на хості (особливо актуально для Proxmox LXC).

Права доступу: Якщо дані не зберігаються, повторно виконайте chmod -R 777 ./data/db.