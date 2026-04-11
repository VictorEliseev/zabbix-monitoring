# Zabbix Infrastructure Deployment

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-blue?style=flat-square&logo=zabbix&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Secure-informational?style=flat-square&logo=tailscale)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

### Project Overview / Огляд проекту
Automated templates for deploying a hybrid Zabbix monitoring ecosystem using Docker and Tailscale. Works on Bare Metal, VM, or Cloud instances.
Автоматизовані шаблони для розгортання гібридної екосистеми моніторингу Zabbix. Підходить для фізичних серверів, віртуальних машин або хмарних інстансів.

---

### Troubleshooting & Stability / Усунення несправностей

* **Agent Version**: Use Zabbix Agent (v1) for Docker environments. Avoid Agent 2 to prevent initialization errors. / Використовуйте Zabbix Agent (v1). Уникайте Agent 2, щоб запобігти помилкам ініціалізації.
* **Hostname Sync**: `ZBX_HOSTNAME_SERVER` in `.env` must strictly match the "Host name" in Zabbix Web UI. / Значення у `.env` має суворо збігатися з ім'ям хоста в інтерфейсі.
* **Internal Connectivity**: Use DNS name `zabbix-agent` and port `10050` for local monitoring. / Для локального моніторингу використовуйте DNS-ім'я `zabbix-agent`.

---

### Critical Tailscale Setup / Важливі налаштування

1. **Node Auth**: Run `docker logs ts-server` (or `ts-proxy`) to get the authorization link for new nodes. / Отримайте посилання для авторизації через логи контейнера.
2. **Key Expiry**: Disable key expiry in Tailscale Admin Console for all monitoring nodes. / Вимкніть термін дії ключів для безперебійної роботи.

---

### Documentation / Документація

| Component / Компонент | English | Українська |
| :--- | :---: | :---: |
| **Server Hub** | [Read Guide](docs/server/en/server_setup.md) | [Читати інструкцію](docs/server/ua/server_setup.md) |
| **Remote Proxy** | [Read Guide](docs/proxy/en/proxy_setup.md) | [Читати інструкцію](docs/proxy/ua/proxy_setup.md) |
| **SSH & Access** | [Setup Guide](docs/ssh_master_setup.md) | [Налаштування доступу](docs/ssh_master_setup.md) |

---

### Maintenance / Обслуговування
* **Naming Conventions**: Follow the [SSH Naming Rules](docs/ssh_naming_rules.md) for organized infrastructure.
* **Environment Setup**: Use `.env.example` as a baseline for every new deployment.

---
*Created by Victor Eliseev & Gemini for efficient multi-location monitoring.*
