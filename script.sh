#!/bin/bash

# Clean previous build if exists
[[ -d build ]] && rm -rf build
mkdir build

# Archive for iOS devices
xcodebuild archive \
    -project NFCPassportReader.xcodeproj \
    -scheme NFCPassportReader \
    -configuration Release \
    -destination "generic/platform=iOS" \
    -archivePath "./build/iOS.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SWIFT_TREAT_WARNINGS_AS_ERRORS=NO \
    OTHER_SWIFT_FLAGS="-no-verify-emitted-module-interface"

# Archive for iOS Simulator
xcodebuild archive \
    -project NFCPassportReader.xcodeproj \
    -scheme NFCPassportReader \
    -configuration Release \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "./build/iOS-Simulator.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SWIFT_TREAT_WARNINGS_AS_ERRORS=NO \
    OTHER_SWIFT_FLAGS="-no-verify-emitted-module-interface"

# Create XCFramework
xcodebuild -create-xcframework \
    -framework "./build/iOS.xcarchive/Products/Library/Frameworks/NFCPassportReader.framework" \
    -framework "./build/iOS-Simulator.xcarchive/Products/Library/Frameworks/NFCPassportReader.framework" \
    -output "./build/NFCPassportReader.xcframework"