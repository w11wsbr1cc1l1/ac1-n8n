# n8n Local Development Environment

Self-hosted n8n workflow automation platform running on Docker with PostgreSQL database.

## 🚀 Quick Start

```bash
# Start n8n and PostgreSQL
docker compose up -d

# View logs
docker compose logs -f n8n

# Stop services
docker compose down

# Stop and remove all data (⚠️ destructive)
docker compose down -v
```

Access n8n at: **http://localhost:5678**

Default credentials:
- **Username:** `admin`
- **Password:** `admin`

⚠️ **Change these in `.env` before using in production!**

## 📋 Prerequisites

- Docker Desktop installed and running
- Docker Compose v3.8+
- Ports 5678 available

## 🔧 Configuration

Edit `.env` file to customize:

```bash
# Database
POSTGRES_USER=n8n
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=n8n

# n8n Port
N8N_PORT=5678

# Authentication
N8N_BASIC_AUTH_USER=your_username
N8N_BASIC_AUTH_PASSWORD=your_secure_password

# Timezone
TIMEZONE=Europe/Berlin
```

## 📁 Folder Structure

```
ac1-n8n/
├── docker-compose.yml     # Docker services configuration
├── .env                   # Environment variables
├── shared/                # Shared files between host and n8n
├── README.md              # This file
└── start.sh               # Quick start script
```

## 🎯 Following the Tutorial

1. **Start n8n:**
   ```bash
   ./start.sh
   ```

2. **Open browser:** http://localhost:5678

3. **Login** with credentials from `.env`

4. **Create workflow:**
   - Click "+" or "Add first step..."
   - Choose trigger (Manual, Schedule, Webhook, etc.)
   - Add nodes and connect them
   - Test and activate

## 🔌 Common Nodes to Try

- **HTTP Request** - Call APIs
- **Code** - Run JavaScript/Python
- **Schedule Trigger** - Run on schedule
- **Webhook** - Trigger via HTTP
- **PostgreSQL** - Database operations
- **Send Email** - SMTP email
- **Slack** - Post messages
- **OpenAI** - AI integrations

## 🛠️ Useful Commands

```bash
# Start services
docker compose up -d

# View logs
docker compose logs -f

# Restart n8n only
docker compose restart n8n

# Stop services
docker compose stop

# Stop and remove (keeps data)
docker compose down

# Stop and remove all data
docker compose down -v

# Check service status
docker compose ps

# Execute commands in n8n container
docker compose exec n8n /bin/sh

# Backup n8n data
docker compose exec postgres pg_dump -U n8n n8n > backup_$(date +%Y%m%d).sql
```

## 📊 Database Access

Connect to PostgreSQL:
```bash
docker compose exec postgres psql -U n8n -d n8n
```

## 🔐 Security Notes

- **Change default passwords** in `.env`
- **Don't commit `.env`** to git (already in `.gitignore`)
- For production, use proper secrets management
- Consider using HTTPS with reverse proxy (nginx/traefik)

## 🐛 Troubleshooting

### Port already in use
```bash
# Check what's using port 5678
lsof -i :5678

# Change N8N_PORT in .env to another port (e.g., 5679)
```

### Database connection issues
```bash
# Check if postgres is healthy
docker compose ps

# View postgres logs
docker compose logs postgres

# Restart services
docker compose restart
```

### Clear all data and restart
```bash
docker compose down -v
docker compose up -d
```

## 📚 Resources

- [n8n Documentation](https://docs.n8n.io/)
- [n8n Community](https://community.n8n.io/)
- [Workflow Templates](https://n8n.io/workflows)
- [Node Reference](https://docs.n8n.io/integrations/)

## 🎓 Tutorial Topics

Common workflow patterns:
1. **Web scraping** - HTTP Request + HTML Extract + Database
2. **Data sync** - Schedule + API Call + Transform + Save
3. **Webhooks** - Webhook Trigger + Process + Respond
4. **AI automation** - Trigger + OpenAI + Format + Send
5. **Monitoring** - Schedule + Check + Alert (Email/Slack)

## 💾 Data Persistence

Data is stored in Docker volumes:
- `postgres_data` - Database
- `n8n_data` - Workflows, credentials, executions
- `shared/` - Files shared between host and container

Volumes persist even after `docker compose down`.
