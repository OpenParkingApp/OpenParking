// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenParkingBase",
    products: [
        .library(
            name: "OpenParkingBase",
            targets: ["OpenParkingBase"]),
        .library(
            name: "OpenParkingTests",
            targets: ["OpenParkingTests"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.2.3"),
        .package(url: "https://github.com/alexaubry/HTMLString", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "OpenParkingBase",
            dependencies: ["AnyCodable", "HTMLString"]),
        .target(
            name: "OpenParkingTests",
            dependencies: ["OpenParkingBase"]),
        .testTarget(
            name: "OpenParkingBaseTests",
            dependencies: ["OpenParkingBase"]),
    ]
)
