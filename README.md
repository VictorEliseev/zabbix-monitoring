# Zabbix Infrastructure Deployment 🛠️

![Zabbix](https://img.shields.io/badge/Zabbix-7.0-blue?style=flat-square&logo=zabbix&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Secure-informational?style=flat-square&logo=tailscale)

---

### Project Overview / Огляд проекту
Automated templates for deploying a hybrid Zabbix monitoring ecosystem using Docker and Tailscale. Supports centralized server management and remote branch monitoring via proxies.
Автоматизовані шаблони для розгортання гібридної екосистеми моніторингу Zabbix за допомогою Docker та Tailscale. Підтримується централізоване керування сервером та моніторинг віддалених філій через проксі.

### Key Features / Ключові особливості
* **Infrastructure as Code (IaC)**: Full automation through Docker Compose and standardized Shell scripts. / Повна автоматизація через Docker Compose та стандартизовані Shell-скрипти.
* **Multilanguage Support**: All documentation and system comments are provided in both English and Ukrainian. / Мультимовна підтримка: вся документація та системні коментарі надаються англійською та українською мовами.
* **Hybrid Connectivity**: Seamless integration of remote locations using Tailscale VPN tunnel. / Гібридне підключення: безшовна інтеграція віддалених локацій через VPN-тунель Tailscale.

---

### ⚠️ Critical Tailscale Setup / Важливі налаштування Tailscale

To ensure stable connectivity, follow these manual steps in the [Tailscale Admin Console](https://login.tailscale.com/admin/machines):
Для забезпечення стабільного зв'язку виконайте ці кроки в адмін-панелі Tailscale:

1. **Server Auth**: After the first run, check `docker logs tailscale-node` for the login URL to authorize the main server. / **Авторизація сервера**: Після першого запуску перевірте логи контейнера для отримання посилання на авторизацію.
2. **Disable Key Expiry**: For both Server and Proxy nodes, select **"Disable Key Expiry"** to prevent connection drops every 180 days. / **Вимкнення експірації**: Для сервера та проксі вимкніть термін дії ключів, щоб уникнути розриву зв'язку через 180 днів.
3. **Approve Subnet Routes**: For remote proxies, go to **Edit Route Settings** and manually approve the advertised local subnets (e.g., 192.168.x.x) to allow Zabbix to see the branch hardware. / **Підтвердження маршрутів**: Для проксі вручну підтвердіть маршрути (Subnet Routes) в адмінці, щоб Zabbix бачив залізо у філіях.

---

### Documentation / Документація

| Role / Роль | English 🇬🇧 | Українська 🇺🇦 |
| :--- | :---: | :---: |
| **Server Setup** (Центральний вузол) | [Read](docs/server/en/server_setup.md) | [Читати](docs/server/ua/server_setup.md) |
| **Proxy Setup** (Віддалений проксі) | [Read](docs/proxy/en/proxy_setup.md) | [Читати](docs/proxy/ua/proxy_setup.md) |

---

### Quick Start / Швидкий старт
1. **Configure environment**: Copy `.env.example` to `.env` and fill in your credentials. / **Налаштуйте середовище**: Скопіюйте `.env.example` у `.env` та впишіть ваші дані.
2. **Deploy Proxy**: Run `./proxy/deploy_proxy.sh` to initialize the branch node. / **Розгорніть проксі**: Запустіть `./proxy/deploy_proxy.sh` для ініціалізації вузла філії.
3. **Deploy Server**: Utilize templates in the `server/` directory for central node setup. / **Розгорніть сервер**: Використовуйте шаблони в директорії `server/` для налаштування центрального вузла.