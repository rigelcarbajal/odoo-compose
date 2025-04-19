# 🧩 Odoo Docker Compose Stack

This repository provides a complete Docker Compose setup for **Odoo**, using **PostgreSQL** as the database and **Nginx** as a reverse proxy. It is designed for local development and staging environments, with persistent volumes and modular configuration.

---

## 🚀 Services

### 🔹 `web` (Odoo 18 or latest)
- Base image: `odoo:18`
- Ports:
  - `8069`: Odoo web interface
  - `8072`: Longpolling / Websocket (Live Chat)
- Mounted volumes:
  - `odoo-web-data`: Odoo data volume
  - `./config`: Custom Odoo configuration (`odoo.conf`)
  - `./addons`: Custom modules
- Healthcheck: Monitors HTTP availability on port 8069
- Auto-restarts unless manually stopped

### 🔹 `db` (PostgreSQL 15)
- Base image: `postgres:15`
- Environment variables:
  - `POSTGRES_DB=postgres`
  - `POSTGRES_USER=odoo`
  - `POSTGRES_PASSWORD=odoo`
- Data stored in `odoo-db-data`
- Healthcheck: Validates readiness with `pg_isready`

### 🔹 `nginx` (Reverse Proxy)
- Base image: `nginx:stable`
- Ports:
  - `80`: HTTP
  - `443`: HTTPS
- Mounted volumes:
  - `./nginx/conf.d`: Nginx site configuration
  - `./nginx/certs`: SSL certificates
- Healthcheck: Verifies proxy availability via `/health` endpoint

---

## 🧱 Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 📦 Usage

```bash
# Clone the repository
git clone https://github.com/rigelcarbajal/odoo-compose.git
cd odoo-compose


# Launch the stack
docker compose up -d

# Check container health and status using:
docker compose ps
```

## 🗂 Project Structure

```text
odoo-compose/
├── addons/                   # Custom Odoo modules
├── config/                   # Custom Odoo configuration (e.g. odoo.conf)
├── nginx/
│   ├── certs/                # SSL certificates
│   └── conf.d/               # Nginx virtual host configs
├── docker-compose.yml        # Main Docker Compose configuration
├── .gitignore                # Git ignored files
├── README.md                 # Project documentation (this file)
└── LICENSE                   # Project license
```

## 🔒 Security Notes

This stack is intended for development purposes.

For production, consider:
	•	Changing default credentials
	•	Securing access to exposed ports
	•	Using trusted SSL certificates
	•	Enabling HTTPS-only access via Nginx

## 📈 Healthcheck Overview

| Service | Check Command               | Interval | Timeout | Retries | Description                     |
|---------|-----------------------------|----------|---------|---------|---------------------------------|
| `web`   | `curl -f http://localhost:8069` | 15s      | 10s     | 5       | Checks if Odoo web is reachable |
| `db`    | `pg_isready -U odoo`         | 10s      | 5s      | 5       | Checks if PostgreSQL is ready   |
| `nginx` | `curl -f http://localhost/health` | 15s      | 5s      | 3       | Checks if Nginx is responding   |





### ✨ Author
@RigelCarbajal

 
