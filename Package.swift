// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "OpenParking",
    products: [
        .library(
            name: "OpenParking",
            targets: ["OpenParking"]),
        .library(
            name: "OpenParkingTestSupport",
            targets: ["OpenParkingTestSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.2.3"),
        .package(url: "https://github.com/alexaubry/HTMLString", from: "5.0.0"),
        .package(url: "https://github.com/sharplet/Regex", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "OpenParking",
            dependencies: ["AnyCodable", "HTMLString", "Regex"]),
        .target(
            name: "OpenParkingTestSupport",
            dependencies: ["OpenParking"]),
        .testTarget(
            name: "OpenParkingTests",
            dependencies: ["OpenParking"]),
    ]
)
