#!/bin/bash
set -e

PROJECT="NFCPassportReader.xcodeproj"
SCHEME="NFCPassportReader"
BUILD_DIR="./build"
XCFRAMEWORK_NAME="NFCPassportReader.xcframework"

DEVICE_ARCHIVE="$BUILD_DIR/$SCHEME-iOS.xcarchive"
SIMULATOR_ARCHIVE="$BUILD_DIR/$SCHEME-iOS-Simulator.xcarchive"

# Clean previous build
rm -rf "$BUILD_DIR"

echo "📦 Archiving for iOS devices..."
xcodebuild archive \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS" \
  -archivePath "$DEVICE_ARCHIVE" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "📦 Archiving for iOS Simulator..."
xcodebuild archive \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "$SIMULATOR_ARCHIVE" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "🔗 Creating XCFramework..."
xcodebuild -create-xcframework \
  -framework "$DEVICE_ARCHIVE/Products/Library/Frameworks/$SCHEME.framework" \
  -framework "$SIMULATOR_ARCHIVE/Products/Library/Frameworks/$SCHEME.framework" \
  -output "$BUILD_DIR/$XCFRAMEWORK_NAME"

echo "✅ Done. Output: $BUILD_DIR/$XCFRAMEWORK_NAME"