// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NamedPoint",
    products: [
        .library(name: "NamedPoint", targets: ["NamedPoint"]),
    ],
    dependencies: [
        .package(path: "Assert")
    ],
    targets: [
        .target(name: "NamedPoint", dependencies: []),
        .testTarget(name: "NamedPointTests", dependencies: ["NamedPoint", "Assert"]),
    ]
)
