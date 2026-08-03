// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "ProjectCore",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "ProjectCore",
            targets: ["ProjectCore"]
        ),
    ],
    targets: [
        .target(
            name: "ProjectCore",
        ),
        .testTarget(
            name: "ProjectCoreTests",
            dependencies: ["ProjectCore"]
        ),
    ]
)
