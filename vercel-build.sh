#!/bin/bash
set -e

echo "=== Astromett Vercel Production Build ==="

# Check if Flutter exists, otherwise download stable Flutter SDK
if [ ! -d "$HOME/flutter" ]; then
  echo "--> Provisioning Flutter stable SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$HOME/flutter"
else
  echo "--> Using cached Flutter SDK in $HOME/flutter"
fi

export PATH="$HOME/flutter/bin:$PATH"

echo "--> Flutter SDK version:"
flutter --version

echo "--> Pre-caching web engine dependencies..."
flutter precache --web

echo "--> Resolving dependencies..."
flutter pub get

echo "--> Building Flutter Web for production..."
flutter build web --release

echo "=== Build Complete! Production assets ready in build/web ==="

