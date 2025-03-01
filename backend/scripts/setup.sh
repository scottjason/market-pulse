#!/bin/bash

echo "🚀 Setting up the backend..."

# Navigate to backend directory
cd "$(dirname "$0")/../../backend"

# Ensure virtual environment exists
if [ ! -d "venv" ]; then
  echo "🔧 Creating virtual environment..."
  python3 -m venv venv
fi

# Detect shell type and activate virtual environment accordingly
if [[ "$SHELL" == *"zsh"* ]]; then
  echo "🟢 Activating virtual environment (zsh)..."
  source venv/bin/activate
else
  echo "🟢 Activating virtual environment (bash)..."
  source venv/bin/activate
fi

# Upgrade pip
pip install --upgrade pip

# Ensure requirements.txt exists before installing
if [ -f "requirements.txt" ]; then
  echo "📦 Installing dependencies from requirements.txt..."
  pip install -r requirements.txt
else
  echo "❌ ERROR: requirements.txt not found in backend/ directory!"
  exit 1
fi

# Ensure alembic is installed before running migrations
if ! pip show alembic &>/dev/null; then
  echo "⚠️ Alembic not found! Installing..."
  pip install alembic
fi

# Run Alembic migrations
echo "📊 Running database migrations..."
alembic upgrade head

echo "✅ Backend setup complete!"
