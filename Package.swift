// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AiactivUniversalSDK",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AiactivUniversalSDK",
            targets: ["AiactivUniversalSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "AiactivUniversalSDK",
            path: "./Resources/1.2.2/AiactivUniversalSDK.xcframework.zip")
    ]
)
