# Zabbix Proxy Setup Guide

This guide provides a step-by-step walkthrough for deploying a Zabbix Proxy in Active Mode using Docker and SQLite3.

---

## 1. Environment Configuration

Create a `.env` file in your working directory to store the core parameters.

```bash
# The unique name of the proxy as it will appear in Zabbix Web UI
ZBX_HOSTNAME=Proxy-Remote-Office
ZBX_SERVER_HOST=100.x.x.x # Your Zabbix Server Tailscale IP
ZBX_PROXYMODE=0 # 0 for Active, 1 for Passive
```

## 2. Docker Compose File

Create a `docker-compose.yml` file with the following content:

```yaml
version: '3.5'
services:
  zabbix-proxy:
    image: zabbix/zabbix-proxy-sqlite3:alpine-7.0-latest
    restart: always
    ports:
      - "10051:10051"
    env_file:
      - .env
    volumes:
      - ./zbx_proxy_db:/var/lib/zabbix/db
```

## 3. Deployment

Run the following command to start the proxy:

```bash
docker-compose up -d
```