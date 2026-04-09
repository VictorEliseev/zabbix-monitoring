# Zabbix Server Deployment Guide (Cloud/On-Prem)

This guide provides instructions for deploying the central **Zabbix Server Hub**.

## Overview
The setup consists of:
* **Zabbix Server 7.0 (LTS)**: Core monitoring engine.
* **PostgreSQL 16 + TimescaleDB**: High-performance database.
* **Tailscale**: Secure VPN tunnel for remote connectivity.
* **Nginx Proxy Manager**: Reverse proxy for SSL termination.

---

## Deployment Steps

### 1. Prepare Environment
Navigate to the server directory and create \`.env\`:
\`\`\`bash
cd server/
cp .env.example .env
\`\`\`
Edit \`.env\` and fill in your passwords and **Tailscale Auth Key**.

### 2. Initialize the Database
Ensure the \`init_timescaledb.sql\` file is present in the server directory.

### 3. Run the Deployment Script
Execute the automation script:
\`\`\`bash
chmod +x deploy_server.sh
./deploy_server.sh
\`\`\`

### 4. Verify Connectivity
Check if the Tailscale tunnel is active:
\`\`\`bash
docker exec ts-server tailscale status
\`\`\`

---

## Post-Installation

### SSL Configuration (Nginx Proxy Manager)
1. Access NPM Web UI (\`http://your-server-ip:81\`).
2. Create a **Proxy Host**:
   * **Forward Hostname**: \`zabbix-web\`
   * **Forward Port**: \`8080\`
3. Enable **SSL**.

### Zabbix Web Setup
1. Open your domain in a browser.
2. Database connection:
   * **Database host**: \`zabbix-db\`
   * **User/Password**: From your .env.
