// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "OpenSSL",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "OpenSSL",
            targets: ["OpenSSL"]),
    ],
    targets: [
        .binaryTarget(
            name: "OpenSSL",
            path: "Frameworks/OpenSSL.xcframework"
        )
    ]
)
