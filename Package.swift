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
            name: "Routely",
            targets: ["Routely"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.62.2"),
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.7.0"),
    ],
    targets: [
        .target(
            name: "Routely",
            dependencies: ["DeviceKit"],
            plugins: [swiftLintPlugin]
        ),
    ]
)
