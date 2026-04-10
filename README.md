# Zabbix Infrastructure Deployment 🛠️

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-blue?style=flat-square&logo=zabbix&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Secure-informational?style=flat-square&logo=tailscale)

---

### Project Overview / Огляд проекту
Automated templates for deploying a hybrid Zabbix monitoring ecosystem using Docker and Tailscale.
Автоматизовані шаблони для розгортання гібридної екосистеми моніторингу Zabbix за допомогою Docker та Tailscale.

### 🔧 Troubleshooting & Stability / Усунення несправностей та стабільність

* **Agent Version / Версія агента**: We use the classic Zabbix Agent (v1) for stability. Avoid Agent 2 in this environment to prevent `enc_internal` initialization errors. / Ми використовуємо класичний Zabbix Agent (v1) для стабільності. Уникайте Agent 2 у цьому середовищі, щоб запобігти помилкам ініціалізації `enc_internal`.
* **Hostname Sync / Синхронізація імен**: The `ZBX_HOSTNAME_SERVER` in `.env` must strictly match the "Host name" in the Zabbix Web UI. / Значення `ZBX_HOSTNAME_SERVER` у `.env` має суворо збігатися з "Host name" у веб-інтерфейсі Zabbix.
* **Internal Connectivity / Внутрішній зв'язок**: For local server monitoring, use DNS name `zabbix-agent` and port `10050` in Zabbix Host settings. / Для моніторингу локального сервера використовуйте DNS-ім'я `zabbix-agent` та порт `10050` у налаштуваннях хоста Zabbix.

---

### ⚠️ Critical Tailscale Setup / Важливі налаштування Tailscale

1. **Server Auth**: Check `docker logs ts-server` for the login URL to authorize the node. / **Авторизація сервера**: Перевірте логи контейнера `ts-server` для отримання посилання на авторизацію.
2. **Disable Key Expiry**: Ensure key expiry is disabled in the Tailscale Admin Console for server and proxy nodes. / **Вимкнення експірації**: Переконайтеся, що термін дії ключів вимкнено в адмінці Tailscale для сервера та проксі.

---

### Documentation / Документація

| Role / Роль | English 🇬🇧 | Українська 🇺🇦 |
| :--- | :---: | :---: |
| **Server Setup** | [Read](docs/server/en/server_setup.md) | [Читати](docs/server/ua/server_setup.md) |
| **Proxy Setup** | [Read](docs/proxy/en/proxy_setup.md) | [Читати](docs/proxy/ua/proxy_setup.md) |