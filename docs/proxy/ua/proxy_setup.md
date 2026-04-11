# Інструкція з налаштування Zabbix Proxy (Active Mode) через Tailscale

Цей документ описує процес розгортання Zabbix Proxy у Docker-контейнері з використанням Tailscale для безпечного тунелювання трафіку до сервера.

## 1. Робота з файлом оточення (.env)

Docker-compose за замовчуванням шукає змінні у файлі з назвою `.env`.

1. **Створення файлу:**
   Скопіюйте шаблон (якщо він є) або створіть новий файл:
   ```bash
   cp .env.example .env
   ```
   *Важливо: Назва має бути суворо `.env`.*

2. **Безпека:**
   Оскільки у файлі зберігатимуться ключі авторизації, обмежте права доступу:
   ```bash
   chmod 600 .env
   ```

## 2. Ключі авторизації Tailscale (Auth Keys)

Щоб контейнер автоматично реєструвався у вашій мережі Tailscale:

1. Перейдіть до Tailscale Admin Console.
2. Натисніть **Generate auth key**.
3. **Налаштування ключа:**
   - Ephemeral: Увімкнути.
   - Preauthorized: Увімкнути.
4. Скопіюйте отриманий ключ (`tskey-auth-...`).

## 3. Налаштування змінних у .env

Відкрийте `.env` і переконайтеся, що заповнені наступні параметри:

```env
# Параметри Zabbix
ZBX_HOSTNAME=Proxy-Site-Name     # Має збігатися з іменем у Zabbix Web
ZBX_SERVER_HOST=100.x.y.z       # IP Zabbix сервера в мережі Tailscale
ZBX_PROXYMODE=0                 # 0 = Active

# Параметри Tailscale
TS_AUTHKEY=tskey-auth-...        # Ваш ключ із кроку 2
TS_EXTRA_ARGS=--hostname=zabbix-proxy-site1
```

## 4. Запуск та обслуговування

**Запуск стека:**
```bash
docker-compose up -d
```

**Перевірка логів:**
```bash
docker logs -f zabbix-proxy
```

**Перевірка мережі:**
```bash
docker exec -it zabbix-proxy ping 100.x.y.z
```