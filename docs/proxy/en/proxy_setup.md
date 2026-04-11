# Zabbix Proxy Configuration Guide (Active Mode) via Tailscale

This document describes the process of deploying a Zabbix Proxy in a Docker container using Tailscale for secure traffic tunneling to the server.

## 1. Working with the Environment File (.env)

By default, Docker-compose looks for variables in a file named `.env`.

1. **Create the file:**
   Copy the template (if available) or create a new file:
   ```bash
   cp .env.example .env
   ```
   *Note: The filename must be exactly `.env`.*

2. **Security:**
   Since this file will store authorization keys, restrict access permissions:
   ```bash
   chmod 600 .env
   ```

## 2. Tailscale Auth Keys

To allow the container to automatically register in your Tailscale network:

1. Go to the Tailscale Admin Console.
2. Click **Generate auth key**.
3. **Key Settings:**
   - Ephemeral: Enabled.
   - Preauthorized: Enabled.
4. Copy the generated key (`tskey-auth-...`).

## 3. Configuring Variables in .env

Open `.env` and ensure the following parameters are filled:

```env
# Zabbix Parameters
ZBX_HOSTNAME=Proxy-Site-Name     # Must match the name in Zabbix Web UI
ZBX_SERVER_HOST=100.x.y.z       # Zabbix Server IP within the Tailscale network
ZBX_PROXYMODE=0                 # 0 = Active

# Tailscale Parameters
TS_AUTHKEY=tskey-auth-...        # Your key from step 2
TS_EXTRA_ARGS=--hostname=zabbix-proxy-site1
```

## 4. Deployment and Maintenance

**Start the stack:**
```bash
docker-compose up -d
```

**Check logs:**
```bash
docker logs -f zabbix-proxy
```

**Verify network connectivity:**
```bash
docker exec -it zabbix-proxy ping 100.x.y.z
```