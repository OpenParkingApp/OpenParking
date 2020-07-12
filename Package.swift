// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "OpenParking",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v11),
    ],
    products: [
        .library(
            name: "OpenParking",
            targets: ["OpenParking"]),
        .library(
            name: "OpenParkingTestSupport",
            targets: ["OpenParkingTestSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kiliankoe/GeoJSON", from: "0.4.0"),
        .package(url: "https://github.com/alexaubry/HTMLString", from: "5.0.0"),
        .package(url: "https://github.com/sharplet/Regex", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "OpenParking",
            dependencies: [
                "GeoJSON",
                "HTMLString",
                "Regex",
            ]),
        .target(
            name: "OpenParkingTestSupport",
            dependencies: ["OpenParking"]),
        .testTarget(
            name: "OpenParkingTests",
            dependencies: ["OpenParking"]),
    ]
)
