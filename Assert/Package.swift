// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Assert",
    products: [
        .library(name: "Assert", targets: ["Assert"]),
    ],
    targets: [
        .target(name: "Assert", dependencies: [ ]),
    ]
)
