#!/bin/bash

# n8n Quick Start Script

echo "🚀 Starting n8n..."
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "Please create .env file or copy from .env.example"
    exit 1
fi

# Start services
docker compose up -d

echo ""
echo "⏳ Waiting for services to start..."
sleep 5

# Check if services are running
if docker compose ps | grep -q "Up"; then
    echo ""
    echo "✅ n8n is running!"
    echo ""
    echo "🌐 Access n8n at: http://localhost:5678"
    echo ""
    echo "📝 Default credentials (change in .env):"
    echo "   Username: admin"
    echo "   Password: admin"
    echo ""
    echo "📊 View logs:"
    echo "   docker compose logs -f"
    echo ""
    echo "🛑 Stop n8n:"
    echo "   docker compose down"
    echo ""
else
    echo ""
    echo "❌ Failed to start services. Check logs:"
    echo "   docker compose logs"
fi
