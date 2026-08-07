// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "ProjectCore",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
    ],
    products: [
        .library(name: "ProjectCore", targets: ["ProjectCore"]),
        .library(name: "ProjectProtocol", targets: ["ProjectProtocol"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ProjectProtocol",
        ),
        .target(
            name: "ProjectCore",
            dependencies: [
                "ProjectProtocol",
            ]
        )
        .testTarget(
            name: "ProjectCoreTests",
            dependencies: [
                "ProjectCore"
            ]
        ),
    ]
)
