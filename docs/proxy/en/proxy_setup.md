# **Zabbix Proxy Deployment Guide (Active Mode)**

This guide describes the deployment of Zabbix Proxy version 7.0 LTS using Docker.

## **Overview**

Zabbix Proxy is a process that collects monitoring data from one or more monitored devices and sends the information to the Zabbix server. It requires a local database (SQLite3 is used in this setup).

## **Docker Configuration**

We use the Alpine Linux-based image for minimal footprint and maximum security.

### **Key Environment Variables (.env):**

* ZBX\_HOSTNAME: A unique, case-sensitive name for the proxy (e.g., Branch-Office-Proxy).  
* ZBX\_SERVER\_HOST: The Tailscale (or VPN) IP address of your Zabbix Server.  
* ZBX\_PROXYMODE: 0 (Active mode — default).  
* ZBX\_SERVER\_PORT: 10051 (Default port).

## **Deployment Steps**

1. **Environment Preparation**:  
   Ensure Tailscale is connected and you can ping the Zabbix Server's internal IP.  
   cd proxy/  
   cp .env.example .env

2. **Start the Proxy**:  
   docker-compose up \-d

3. **Verify Connection**:  
   Check the container logs to ensure the proxy successfully connects to the server:  
   docker logs \-f zabbix-proxy

## **Zabbix Server Configuration**

1. Log in to the Zabbix Web Interface.  
2. Go to **Administration** \-\> **Proxies**.  
3. Click **Create proxy**.  
4. **Proxy name**: Must be EXACTLY the same as ZBX\_HOSTNAME.  
5. **Proxy mode**: Active.  
6. Click **Add**.

Wait for 1-2 minutes. The **Last seen (age)** column should show a value once the proxy checks in.