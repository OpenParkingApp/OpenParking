// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenParkingBase",
    products: [
        .library(
            name: "OpenParkingBase",
            targets: ["OpenParkingBase"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "OpenParkingBase",
            dependencies: []),
        .testTarget(
            name: "OpenParkingBaseTests",
            dependencies: ["OpenParkingBase"]),
    ]
)
