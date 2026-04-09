# Посібник із розгортання Zabbix Server (Cloud/On-Prem)

Цей посібник містить інструкції щодо розгортання центрального **Zabbix Server Hub** за допомогою Docker, PostgreSQL з TimescaleDB та Tailscale.

## Огляд
Ця конфігурація включає:
* **Zabbix Server 7.0 (LTS)**: Основне ядро системи моніторингу.
* **PostgreSQL 16 + TimescaleDB**: Високопродуктивна база даних для часових рядів.
* **Tailscale**: Захищений VPN-тунель для підключення віддалених проксі.
* **Nginx Proxy Manager**: Реверс-проксі для SSL та доступу до веб-інтерфейсу.

---

## Етапи розгортання

### 1. Підготовка середовища
Перейдіть у директорію сервера та створіть файл `.env`:
\`\`\`bash
cd server/
cp .env.example .env
\`\`\`
Відредагуйте `.env`, вказавши паролі та ваш **Tailscale Auth Key**.

### 2. Ініціалізація бази даних
Переконайтеся, що файл `init_timescaledb.sql` знаходиться в директорії сервера.

### 3. Запуск скрипта розгортання
Запустіть скрипт для підготовки папок та запуску контейнерів:
\`\`\`bash
chmod +x deploy_server.sh
./deploy_server.sh
\`\`\`

### 4. Перевірка зв'язку
Перевірте статус тунелю та дізнайтеся свою внутрішню IP-адресу:
\`\`\`bash
docker exec ts-server tailscale status
\`\`\`

---

## Післяінсталяційне налаштування

### Конфігурація SSL (Nginx Proxy Manager)
1. Відкрийте веб-інтерфейс NPM (\`http://your-server-ip:81\`).
2. Створіть **Proxy Host**:
   * **Domain Names**: \`zabbix.yourdomain.com\`
   * **Forward Hostname**: \`zabbix-web\`
   * **Forward Port**: \`8080\`
3. Увімкніть **SSL** (Let's Encrypt).

### Налаштування Zabbix Web
1. Відкрийте ваш домен у браузері.
2. Для підключення до БД використовуйте:
   * **Database host**: \`zabbix-db\`
   * **User/Password**: Як визначено у вашому .env.
