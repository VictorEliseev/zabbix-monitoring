# **Посібник із розгортання Zabbix Server (Cloud/On-Prem)**

Цей посібник містить інструкції щодо розгортання центрального **Zabbix Server Hub**.

## **Огляд**

Ця конфігурація включає:

* **Zabbix Server 7.0 (LTS)**: Основне ядро системи моніторингу.  
* **PostgreSQL 16 \+ TimescaleDB**: Високопродуктивна база даних.  
* **Tailscale**: Захищений VPN-тунель для віддаленого зв'язку.  
* **Nginx Proxy Manager**: Реверс-проксі для SSL.

## **Етапи розгортання**

### **1\. Підготовка середовища**

Перейдіть у директорію сервера та створіть файл .env:  
cd server/  
cp .env.example .env

Відредагуйте .env, вказавши паролі та **Tailscale Auth Key**.

### **2\. Запуск скрипта розгортання**

Виконайте автоматизацію:  
chmod \+x deploy\_server.sh  
./deploy\_server.sh

## **Післяінсталяційне налаштування**

### **Конфігурація SSL (Nginx Proxy Manager)**

1. Відкрийте NPM Web UI (http://your-server-ip:81).  
2. Створіть **Proxy Host**:  
   * **Forward Hostname**: zabbix-web  
   * **Forward Port**: 8080  
3. Увімкніть **SSL**.

### **Налаштування Zabbix Web**

1. Відкрийте ваш домен у браузері.  
2. Підключення до БД:  
   * **Database host**: zabbix-db  
   * **User/Password**: З файлу .env.