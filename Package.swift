// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CombineExtension",
  platforms: [
    .iOS(.v13),
    .tvOS(.v12),
    .macOS(.v10_13),
    .watchOS(.v4),
  ],
  products: [
    .library(
      name: "CombineExtension",
      targets: ["CombineExtension"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/cuzv/Infra", branch: "master"),
    .package(url: "https://github.com/CombineCommunity/CombineCocoa", from: "0.4.1"),
    .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.8.1"),
  ],
  targets: [
    .target(
      name: "CombineExtension",
      dependencies: [
        "CombineExt",
        "CombineCocoa",
        "Infra",
      ],
      path: "Sources"
    ),
  ]
)
