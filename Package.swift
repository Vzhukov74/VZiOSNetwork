// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VZiOSNetwork",
    products: [
        .library(
            name: "VZiOSNetwork",
            targets: ["VZiOSNetwork"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "VZiOSNetwork",
            dependencies: []
        ),
        .testTarget(
            name: "VZiOSNetworkTests",
            dependencies: ["VZiOSNetwork"]
        ),
    ]
)
