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