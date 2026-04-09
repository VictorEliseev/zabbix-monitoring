# Zabbix Infrastructure Deployment 🛠️

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-blue?style=flat-square&logo=zabbix&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Secure-informational?style=flat-square&logo=tailscale)

---

### Project Overview / Огляд проекту
This repository provides automated templates for deploying a hybrid Zabbix monitoring ecosystem using Docker and Tailscale. It supports both central server management and remote branch monitoring via proxies.
Цей репозиторій містить автоматизовані шаблони для розгортання гібридної екосистеми моніторингу Zabbix за допомогою Docker та Tailscale. Підтримується як керування центральним сервером, так і моніторинг віддалених філій через проксі.

### Architecture / Архітектура
* **Main Branch**: Infrastructure templates and global documentation. / **Гілка Main**: Шаблони інфраструктури та глобальна документація.
* **Server Node**: Centralized Zabbix Server, Database, and Web Interface. / **Серверний вузол**: Централізований сервер Zabbix, база даних та веб-інтерфейс.
* **Proxy Node**: Remote collector for branch monitoring with SNMP Traps support. / **Проксі-вузол**: Віддалений колектор для моніторингу філій із підтримкою SNMP-трапів.

---

### Documentation / Документація

| Role / Роль | English 🇬🇧 | Українська 🇺🇦 |
| :--- | :---: | :---: |
| **Server Setup** (Центральний вузол) | [Read](docs/server/en/setup.md) | [Читати](docs/server/ua/setup.md) |
| **Proxy Setup** (Віддалений проксі) | [Read](docs/proxy/en/proxy_setup.md) | [Читати](docs/proxy/ua/proxy_setup.md) |

---

### Quick Start / Швидкий старт
1. **Configure environment**: Copy `.env.example` to `.env` and fill in your credentials. [cite_start]/ **Налаштуйте середовище**: Скопіюйте `.env.example` у `.env` та впишіть ваші дані. [cite: 1]
2. **Deploy Proxy**: Run `./proxy/deploy_proxy.sh` to initialize the branch node. / **Розгорніть проксі**: Запустіть `./proxy/deploy_proxy.sh` для ініціалізації вузла філії.
3. **Deploy Server**: Use the deployment script in the `/server` directory. / **Розгорніть сервер**: Використовуйте скрипт розгортання в директорії `/server`.