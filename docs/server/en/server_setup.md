Zabbix Server Deployment Guide (Cloud/On-Prem)
This guide provides instructions for deploying the central Zabbix Server Hub using Docker, PostgreSQL with TimescaleDB, and Tailscale for secure inter-branch connectivity.

Overview
The setup consists of:

Zabbix Server 7.0 (LTS): Core monitoring engine.

PostgreSQL 16 + TimescaleDB: High-performance database for time-series data.

Tailscale: Secure VPN tunnel to connect remote proxies without opening public ports.

Nginx Proxy Manager (NPM): Reverse proxy for SSL termination and Web UI access.

Zabbix Agent 2: Self-monitoring of the host resources.

Prerequisites
Before starting, ensure you have:

Docker & Docker Compose installed on your host.

Tailscale Auth Key: Generate a reusable or ephemeral key in your Tailscale Admin Console.

Public IP & Domain (Optional): If you plan to use Nginx Proxy Manager with Let's Encrypt SSL.

Deployment Steps
1. Prepare Environment
Clone the repository and navigate to the server directory:

Bash
cd server/
Create your private .env file based on the provided template:

Bash
cp .env.example .env
Edit .env and fill in your secure passwords and Tailscale Auth Key.

2. Initialize the Database
Ensure the init_timescaledb.sql file is present in the server directory. It contains the command to activate the time-series extension:

SQL
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
3. Run the Deployment Script
Execute the provided automation script to prepare directories and launch containers:

Bash
chmod +x deploy_server.sh
./deploy_server.sh
4. Verify Connectivity
Check if the Tailscale tunnel is active and find your internal IP:

Bash
docker exec ts-server tailscale status
Note: Use this IP to point your remote Zabbix Proxies to this server.

Post-Installation
SSL Configuration (Nginx Proxy Manager)
Access the NPM Web UI at http://your-server-ip:81.

Default credentials: admin@example.com / changeme.

Create a Proxy Host:

Domain Names: zabbix.yourdomain.com

Forward Hostname: zabbix-web

Forward Port: 8080

Enable SSL (Let's Encrypt) for secure access.

Zabbix Web Setup
Open your domain in a browser.

Follow the Zabbix setup wizard.

For Database connection, use:

Database type: PostgreSQL

Database host: zabbix-db

User/Password: As defined in your .env.

Troubleshooting
Database Errors: Check logs with docker compose logs zabbix-db.

Tailscale Issues: Ensure /dev/net/tun is available on the host (especially on Proxmox LXC/VM).

Permissions: If data isn't saving, re-run chmod -R 777 ./data/db.