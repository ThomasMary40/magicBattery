#!/bin/bash
set -e

echo "Installing MagicBattery..."

# Build
swift build -c release

# Create app bundle
APP_DIR="build/MagicBattery.app/Contents/MacOS"
RES_DIR="build/MagicBattery.app/Contents/Resources"
mkdir -p "$APP_DIR" "$RES_DIR"
cp .build/release/MagicBattery "$APP_DIR/"
cp Resources/Info.plist "build/MagicBattery.app/Contents/"
cp AppIcon.icns "$RES_DIR/"

# Install to /Applications
cp -r build/MagicBattery.app /Applications/MagicBattery.app

# Add to login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/MagicBattery.app", hidden:false}' 2>/dev/null || true

echo ""
echo "✓ MagicBattery installed to /Applications"
echo "✓ Added to login items (starts on boot)"
echo ""
echo "Launching..."
open /Applications/MagicBattery.app
