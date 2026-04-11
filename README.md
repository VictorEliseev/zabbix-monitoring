# Zabbix Infrastructure Deployment

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-blue?style=flat-square&logo=zabbix&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Secure-informational?style=flat-square&logo=tailscale)

---

### Project Overview / Огляд проекту
Automated templates for deploying a hybrid Zabbix monitoring ecosystem using Docker and Tailscale.
Автоматизовані шаблони для розгортання гібридної екосистеми моніторингу Zabbix за допомогою Docker та Tailscale.

---

### Troubleshooting & Stability / Усунення несправностей

* **Agent Version**: Use Zabbix Agent (v1) for Docker environments. Avoid Agent 2 to prevent initialization errors. / Використовуйте Zabbix Agent (v1). Уникайте Agent 2.
* **Hostname Sync**: `ZBX_HOSTNAME_SERVER` in `.env` must strictly match the "Host name" in Zabbix Web UI. / Значення у `.env` має збігатися з ім'ям хоста в інтерфейсі.
* **Internal Connectivity**: Use DNS name `zabbix-agent` and port `10050` for local monitoring. / Для локального моніторингу використовуйте DNS-ім'я `zabbix-agent`.

---

### Critical Tailscale Setup / Важливі налаштування

1. **Node Auth**: Run `docker logs ts-server` to get the authorization link. / Отримайте посилання для авторизації через логи контейнера.
2. **Key Expiry**: Disable key expiry in Tailscale Admin Console for all nodes. / Вимкніть термін дії ключів для безперебійної роботи.

---

### Documentation / Документація

| Component / Компонент | English | Українська |
| :--- | :---: | :---: |
| **Server Hub** | [Read Guide](docs/server/en/server_setup.md) | [Читати інструкцію](docs/server/ua/server_setup.md) |
| **Remote Proxy** | [Read Guide](docs/proxy/en/proxy_setup.md) | [Читати інструкцію](docs/proxy/ua/proxy_setup.md) |
| **SSH & Naming** | [Setup Guide](docs/ssh_master_setup.md) | [Налаштування доступу](docs/ssh_master_setup.md) |

---
*Created by Victor Eliseev & Gemini for efficient multi-location monitoring.*
