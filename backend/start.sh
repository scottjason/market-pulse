#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Check if dependencies are installed
if ! pip list | grep -q "fastapi"; then
  echo "📦 Installing missing dependencies..."
  pip install --no-cache-dir -r requirements.txt
else
  echo "✅ All dependencies are already installed."
fi

# Check for argument (dev or prod)
if [ "$1" == "dev" ]; then
  echo "🚀 Starting FastAPI in DEVELOPMENT mode..."
  uvicorn main:app --host 127.0.0.1 --port 8000 --reload
elif [ "$1" == "prod" ]; then
  echo "🚀 Starting FastAPI in PRODUCTION mode..."
  gunicorn -k uvicorn.workers.UvicornWorker main:app --bind 0.0.0.0:8000 --workers 4
else
  echo "❌ Usage: ./start.sh [dev|prod]"
fi
