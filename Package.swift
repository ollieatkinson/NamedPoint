// swift-tools-version:5.1

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
