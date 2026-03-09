#!/bin/bash
set -e

echo "Building MagicBattery..."
swift build -c release

APP_DIR="build/MagicBattery.app/Contents/MacOS"
mkdir -p "$APP_DIR"
cp .build/release/MagicBattery "$APP_DIR/"
cp Resources/Info.plist "build/MagicBattery.app/Contents/"

RES_DIR="build/MagicBattery.app/Contents/Resources"
mkdir -p "$RES_DIR"
cp AppIcon.icns "$RES_DIR/"

echo "Done! App bundle at: build/MagicBattery.app"
echo "Run with: open build/MagicBattery.app"
