#!/bin/bash

# Check if pnpm is installed
if ! command -v pnpm &>/dev/null; then
  echo "❌ pnpm is not installed. Please install it first:"
  echo "npm install -g pnpm"
  exit 1
fi

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
  echo "📦 Installing missing dependencies..."
  pnpm install
else
  echo "✅ All dependencies are already installed."
fi

# Check for argument (dev or prod)
if [ "$1" == "dev" ]; then
  echo "🚀 Starting Next.js in DEVELOPMENT mode..."
  pnpm dev
elif [ "$1" == "prod" ]; then
  echo "🚀 Building and Starting Next.js in PRODUCTION mode..."
  pnpm build
  pnpm start
else
  echo "❌ Usage: ./start.sh [dev|prod]"
fi
