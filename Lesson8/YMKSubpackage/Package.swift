// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YMKSubpackage",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "YMKSubpackage",
            targets: ["YMKSubpackage"]),
    ],
    // Подтянула через Swift Package Manager библиотеку YandexMapsMobile
    dependencies: [
        .package(url: "https://github.com/c-villain/YandexMapsMobile", from: "4.5.1"),
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "YMKSubpackage",
            dependencies: [
                .product(name: "YandexMapsMobile", package: "YandexMapsMobile")
            ],
            linkerSettings: [
                .linkedFramework("CoreLocation"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("SystemConfiguration"),
                .linkedLibrary("c++"),
                .unsafeFlags(["-ObjC"]),
            ]),
        .testTarget(
            name: "YMKSubpackageTests",
            dependencies: ["YMKSubpackage"]),
    ]
)
