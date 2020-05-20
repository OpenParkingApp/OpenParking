// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Datasource",
    products: [
        .library(
            name: "Datasource",
            targets: ["Datasource"]),
        .library(
            name: "DatasourceValidation",
            targets: ["DatasourceValidation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.2.3"),
        .package(url: "https://github.com/alexaubry/HTMLString", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "Datasource",
            dependencies: ["AnyCodable", "HTMLString"]),
        .target(
            name: "DatasourceValidation",
            dependencies: ["Datasource"]),
        .testTarget(
            name: "DatasourceTests",
            dependencies: ["Datasource"]),
    ]
)
 
