// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftRegressor",
    products: [
        .library(
            name: "Regressor",
            targets: ["Regressor"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Regressor",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            path: "Sources"),
        .testTarget(
            name: "RegressorTests",
            dependencies: [
                "Regressor",
            ],
            path: "Tests"),
    ]
)
