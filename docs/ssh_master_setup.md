# SSH Access & Infrastructure Naming Rules

## Infrastructure Naming Convention / Правила іменування
To keep the monitoring organized, we use the following pattern:
Щоб моніторинг був організованим, ми використовуємо таку схему:

`[PROJECT]-[LOCATION]-[ROLE]-[INDEX]`

**Examples / Приклади:**
* `zb-kyiv-server-01` (Main Zabbix Server in Kyiv)
* `zb-warsaw-proxy-01` (Proxy node in Warsaw)
* `zb-home-agent-01` (Local agent at home office)

---

## SSH Setup / Налаштування SSH

### 1. Key Generation / Генерація ключів
Use Ed25519 for better security:
```bash
ssh-keygen -t ed25519 -C "admin@monitoring"
```

### 2. Tailscale SSH
Since we use Tailscale, you can leverage **Tailscale SSH**. 
1. Enable SSH in the Tailscale admin console.
2. Connect using the Tailscale IP or MagicDNS name:
   ```bash
   ssh user@zb-kyiv-server-01
   ```

### 3. Security Recommendations
* Disable password authentication in `/etc/ssh/sshd_config`.
* Use `AllowUsers` to restrict access.
* Always keep your private keys on an encrypted volume.
