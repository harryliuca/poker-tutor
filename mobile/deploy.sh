#!/bin/bash

# Poker Tutor - Web Deployment Script
# This script builds and deploys the web app to Netlify

echo "🚀 Starting deployment process..."
echo ""

# Step 1: Clean old build
echo "🧹 Cleaning old build..."
rm -rf dist
echo "✅ Old build cleaned"
echo ""

# Step 2: Build for web
echo "📦 Building for web..."
npx expo export --platform web

if [ $? -ne 0 ]; then
  echo "❌ Build failed!"
  exit 1
fi

echo "✅ Build completed successfully"
echo ""

# Step 3: Deploy to Netlify
echo "🌐 Deploying to Netlify..."
netlify deploy --dir=dist --prod

if [ $? -ne 0 ]; then
  echo "❌ Deployment failed!"
  exit 1
fi

echo ""
echo "✅ Deployment completed successfully!"
echo "🌐 Live at: https://poker-tutor.netlify.app"
