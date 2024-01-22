// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CombineExtension",
  platforms: [
    .iOS(.v13),
    .tvOS(.v10),
    .macOS(.v10_12),
    .watchOS(.v3),
  ],
  products: [
    .library(
      name: "CombineExtension",
      targets: ["CombineExtension"]
    ),
  ],
  dependencies: [
    .package(name: "Infra", url: "https://github.com/cuzv/Infra", .branch("master")),
    .package(name: "CombineExt", url: "https://github.com/CombineCommunity/CombineExt", from: "1.7.0"),
  ],
  targets: [
    .target(
      name: "CombineExtension",
      dependencies: [
        "CombineExt",
        "Infra",
      ],
      path: "Sources"
    ),
  ]
)
