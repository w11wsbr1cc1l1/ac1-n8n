# GitHub Setup Guide

## 🔐 Important Security Notes

**⚠️ NEVER commit these files:**
- `.env` - Contains passwords and API keys
- `shared/` folder - May contain sensitive workflow data
- `*.sql` backup files
- Exported workflow JSON files (may contain credentials)

These are already in `.gitignore` to protect you.

## 🚀 Initial Setup

### 1. Create GitHub Repository

Go to [github.com/new](https://github.com/new) and create a new repository:
- Name: `n8n-workflows` (or your preferred name)
- Description: "Self-hosted n8n automation workflows"
- Visibility: **Private** (recommended for security)
- ❌ Don't initialize with README (we already have one)

### 2. Connect Local Repository

```bash
cd /Users/christianlutticke/Documents/B/PROJEKTE/ac_one_metrics/a_prod_running_node2/ac1-n8n

# Add GitHub remote (replace with your username/repo)
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git

# Or using HTTPS:
# git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# Verify remote
git remote -v
```

### 3. Initial Commit & Push

```bash
# Check what will be committed
git status

# Add all files
git add .

# Create initial commit
git commit -m "Initial n8n setup with Docker Compose"

# Push to GitHub
git push -u origin main
```

## 📝 Daily Workflow

### Commit Changes

```bash
# Check what changed
git status

# Add specific files
git add docker-compose.yml README.md

# Or add all changes
git add .

# Commit with descriptive message
git commit -m "Add new workflow for data processing"

# Push to GitHub
git push
```

### Export n8n Workflows

n8n workflows are stored in the database. To version control them:

1. **Export from n8n UI:**
   - Open workflow
   - Click "..." menu
   - Select "Download"
   - Save to `workflows/` folder (create this folder)

2. **Add to git:**
   ```bash
   # Create workflows folder
   mkdir -p workflows
   
   # Move exported JSON files there
   mv ~/Downloads/My_Workflow.json workflows/
   
   # Commit
   git add workflows/
   git commit -m "Add data processing workflow"
   git push
   ```

⚠️ **Review exported workflows** before committing - they may contain:
- API keys
- Passwords
- Webhook URLs
- Database connection strings

## 🔒 Security Best Practices

### Protect Secrets

1. **Use n8n Credentials:**
   - Store secrets in n8n's credential system
   - Never hardcode in workflows

2. **Check Before Committing:**
   ```bash
   # Review changes before commit
   git diff
   
   # Search for potential secrets
   git diff | grep -i "password\|api_key\|token\|secret"
   ```

3. **If You Accidentally Commit Secrets:**
   ```bash
   # Remove from git history
   git filter-branch --force --index-filter \
     'git rm --cached --ignore-unmatch PATH/TO/FILE' \
     --prune-empty --tag-name-filter cat -- --all
   
   # Rotate the exposed credentials immediately!
   ```

### Environment Variables

1. **Copy `.env.example`:**
   ```bash
   cp .env.example .env
   # Then edit .env with your actual values
   ```

2. **Team Setup:**
   - Share `.env.example` (template)
   - Never share `.env` (actual secrets)
   - Document required variables in README

## 📁 Recommended Repository Structure

```
ac1-n8n/
├── .github/
│   └── workflows/          # CI/CD pipelines (optional)
├── docker-compose.yml      # ✅ Commit
├── .env.example            # ✅ Commit (template)
├── .env                    # ❌ Never commit (secrets)
├── .gitignore              # ✅ Commit
├── README.md               # ✅ Commit
├── SETUP_GITHUB.md         # ✅ Commit (this file)
├── start.sh                # ✅ Commit
├── shared/
│   └── .gitkeep            # ✅ Commit (keeps folder)
└── workflows/              # ✅ Commit exported workflows
    ├── data-processing.json
    └── api-integration.json
```

## 🤝 Collaboration

### Clone Repository (New Team Member)

```bash
# Clone
git clone git@github.com:YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# Setup environment
cp .env.example .env
# Edit .env with actual credentials

# Start n8n
docker compose up -d
```

### Pull Latest Changes

```bash
# Get latest code
git pull origin main

# Restart services if config changed
docker compose down
docker compose up -d
```

## 🔄 Backup Strategy

### Database Backups

```bash
# Create backup
docker compose exec postgres pg_dump -U n8n n8n > backups/n8n_$(date +%Y%m%d_%H%M%S).sql

# Restore from backup
docker compose exec -T postgres psql -U n8n -d n8n < backups/n8n_20260510_143000.sql
```

**Note:** Backup files contain credentials - don't commit them!

### Workflow Exports

Export workflows regularly:
1. Manual export from UI
2. Store in `workflows/` folder
3. Commit to git (after reviewing for secrets)

## 📊 GitHub Features to Use

### 1. Issues
Track workflow ideas, bugs, automation requests

### 2. Projects
Organize workflow development roadmap

### 3. Wiki
Document workflow patterns, integrations, troubleshooting

### 4. Releases
Tag stable versions:
```bash
git tag -a v1.0.0 -m "Initial stable release"
git push origin v1.0.0
```

## 🆘 Troubleshooting

### Wrong Remote URL
```bash
# Check current remote
git remote -v

# Change remote URL
git remote set-url origin git@github.com:NEW_USERNAME/NEW_REPO.git
```

### Authentication Issues
```bash
# Test SSH
ssh -T git@github.com

# Or use HTTPS with token
git remote set-url origin https://YOUR_TOKEN@github.com/USERNAME/REPO.git
```

### Merge Conflicts
```bash
# Pull with rebase
git pull --rebase origin main

# Resolve conflicts in files
# Then:
git add .
git rebase --continue
```

## 📚 Resources

- [GitHub Docs](https://docs.github.com)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [n8n Best Practices](https://docs.n8n.io/hosting/best-practices/)
