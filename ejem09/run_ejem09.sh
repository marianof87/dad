#!/usr/bin/env bash
set -euo pipefail

# Move to the directory containing this script
cd "$(dirname "$0")"

echo "🚀 Starting ejem09 services..."
podman compose up -d

# Give containers a moment to initialize
sleep 5

# Helper to test an endpoint and report HTTP status code
test_endpoint() {
  local url=$1
  echo "🔎 Testing $url..."
  local status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  echo "   HTTP status: $status"
}

test_endpoint http://localhost:8080
test_endpoint http://localhost:8081

echo "📋 Current containers:"
podman ps

echo "🛑 Stopping ejem09 services..."
podman compose down

echo "✅ Done."
