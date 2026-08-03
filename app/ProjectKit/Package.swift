// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "ProjectKit",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "ProjectKit",
            targets: ["ProjectKit"]
        ),
    ],
    dependencies: [
        .package(path: "../ProjectCore"),
    ],
    targets: [
        .target(
            name: "ProjectKit",
            dependencies: [
                .product(name: "ProjectCore", package: "ProjectCore"),
            ],
            resources: [
                .process("Assets.xcassets"),
            ]
        ),
        .testTarget(
            name: "ProjectKitTests",
            dependencies: ["ProjectKit"]
        ),
    ]
)
