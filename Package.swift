// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftLintPlugin: PackageDescription.Target.PluginUsage = .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")

let package = Package(
    name: "Routely",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "RoutelyInterfaces",
            targets: ["RoutelyInterfaces"]
        ),
        .library(
            name: "DeepLinking",
            targets: ["DeepLinking"]
        ),
        .library(
            name: "Routely",
            targets: ["Routely"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.1"),
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.6.0"),
    ],
    targets: [
        .target(
            name: "RoutelyInterfaces",
            dependencies: [],
            plugins: [swiftLintPlugin]
        ),
        .target(
            name: "DeepLinking",
            dependencies: ["RoutelyInterfaces"],
            plugins: [swiftLintPlugin]
        ),
        .target(
            name: "Routely",
            dependencies: ["RoutelyInterfaces", "DeepLinking", "DeviceKit"],
            plugins: [swiftLintPlugin]
        ),
    ]
)
