#!/bin/bash

echo "🚀 Running setup script..."

# Check if pnpm is installed, if not, install it
if ! command -v pnpm &>/dev/null; then
  echo "⚠️ pnpm is not installed. Installing pnpm..."
  npm install -g pnpm
else
  echo "✅ pnpm is already installed."
fi

# Define project structure
FRONTEND_DIR="frontend"
BACKEND_DIR="backend"

# Ensure frontend and backend directories exist
if [ ! -d "$FRONTEND_DIR" ]; then
  echo "❌ ERROR: Frontend directory ($FRONTEND_DIR) does not exist. Clone the repository first!"
  exit 1
fi

if [ ! -d "$BACKEND_DIR" ]; then
  echo "❌ ERROR: Backend directory ($BACKEND_DIR) does not exist. Clone the repository first!"
  exit 1
fi

# Setup Backend (Python FastAPI)
echo "🔧 Setting up FastAPI backend..."
cd $BACKEND_DIR

if [ ! -d "venv" ]; then
  python3 -m venv venv
  echo "✅ Created Python virtual environment."
fi

source venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt --no-cache-dir
echo "✅ Backend dependencies installed."

deactivate
echo "✅ FastAPI backend setup complete."

# Setup Frontend (Next.js)
cd ../$FRONTEND_DIR
echo "🔧 Setting up Next.js frontend..."

if [ ! -d "node_modules" ]; then
  echo "📦 Installing frontend dependencies..."
  pnpm install
  echo "✅ Installed frontend dependencies."
else
  echo "✅ Frontend dependencies already installed."
fi

cd ..
echo "✅ Setup complete! 🚀"
