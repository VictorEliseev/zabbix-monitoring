# **Zabbix Server Deployment Guide**

This guide provides comprehensive instructions for deploying the central **Zabbix Server Hub** using Docker and Tailscale.

## **Stack Components**

* **Zabbix Server 7.0 (LTS)**: Central monitoring engine.
* **PostgreSQL 16 + TimescaleDB**: High-performance database.
* **init_timescaledb.sql**: Script to activate the TimescaleDB extension.
* **Tailscale**: Secure VPN tunnel for branch connectivity.
* **Nginx Proxy Manager**: Reverse proxy for SSL management.

## **1. Environment Preparation**

Navigate to the server directory and create the configuration file from the template:

```bash
cd server/
cp .env.example .env
nano .env
```

### **Important: Tailscale Authentication**
* **Option 1**: If you have a pre-generated auth key, paste it into `TS_AUTHKEY`.
* **Option 2**: If you don't have a key, leave `TS_AUTHKEY` **blank**. After deployment, retrieve the auth link from the logs: `docker logs ts-server`.

### **Key Parameters (.env):**
* **ZBX_SERVER_NAME**: The visible name in the Zabbix Web UI.
* **ZBX_HOSTNAME_SERVER**: Internal hostname. **MUST STRICTLY MATCH** the "Host name" field in the Zabbix Web UI.

## **2. Deployment**

Run the automation script. It will create necessary directories and automatically mount the DB initialization file:

```bash
chmod +x deploy_server.sh
./deploy_server.sh
```

## **3. Post-Installation Setup**

### **SSL Configuration (Nginx Proxy Manager)**
1. Open the NPM Web UI (port 81).
2. Create a new **Proxy Host**:
    * **Forward Hostname**: `zabbix-web`
    * **Forward Port**: `8080`
3. Enable **SSL (Let's Encrypt)**.

### **Zabbix Self-Monitoring Setup**
To turn the "ZBX" status icon green:
1. Go to **Data collection -> Hosts** and select your server host.
2. **Host name**: Must be identical to the `ZBX_HOSTNAME_SERVER` value in your `.env`.
3. **Interface**: Add a new interface of type **DNS**, set the name to `zabbix-agent`, and port to `10050`.
4. **Note**: We use **Zabbix Agent v1** for maximum stability in Docker environments.

## **4. Maintenance & Diagnostics**

* **View logs**: `docker compose logs -f zabbix-agent`
* **Restart system**: `docker compose restart`
* **Update configuration**: If you change `.env`, run `docker compose up -d` to apply changes.
