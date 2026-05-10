# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-10

### Added
- Docker Compose setup with n8n and PostgreSQL 16
- Environment-based configuration with `.env` file
- Basic authentication (configurable credentials)
- Persistent data volumes for PostgreSQL and n8n
- Health checks for database container
- Comprehensive documentation:
  - README.md with quick start and troubleshooting
  - SETUP_GITHUB.md for version control workflows
  - .env.example template for new deployments
- Helper scripts:
  - start.sh for quick startup with validation
- GitHub version control setup with proper .gitignore
- Workflow export directory structure

### Fixed
- Removed obsolete `version` field from docker-compose.yml (Docker Compose V2 compatibility)
- Disabled task runners to reduce startup warnings and log noise
- Optimized container dependencies with health condition checks

### Security
- Secrets management with .env (excluded from version control)
- Security best practices documentation
- Proper file permissions on sensitive files

### Notes
- Tested and verified working on macOS with Docker Compose V2
- Default port: 5678
- Default credentials: admin/admin (should be changed in production)

[1.0.0]: https://github.com/w11wsbr1cc1l1/ac1-n8n/releases/tag/v1.0.0
