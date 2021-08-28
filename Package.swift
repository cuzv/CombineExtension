// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineExtension",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12),
        .tvOS(.v10),
        .watchOS(.v3),
    ],
    products: [
        .library(
            name: "CombineExtension",
            targets: ["CombineExtension"]
        ),
    ],
    dependencies: [
        .package(name: "Infrastructure", url: "https://github.com/cuzv/Infrastructure", .branch("master")),
        .package(name: "CombineExt", url: "https://github.com/CombineCommunity/CombineExt", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "CombineExtension",
            dependencies: [
                "CombineExt",
                "Infrastructure",
            ],
            path: "Sources"
        ),
    ]
)
