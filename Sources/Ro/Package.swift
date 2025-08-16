// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Dependencies

let localDependenciesNames: [String] = [
    "ProfileInterfaces",
    "RoutelyInterfaces",
    "DeepLinking",
    "SharedModels",
    "Toolbox",
    "UIToolbox",
]

let localPackageDependencies: [PackageDescription.Package.Dependency] = localDependenciesNames.map { .package(path: "../\($0)") }

let localTargetDependencies: [PackageDescription.Target.Dependency] = localDependenciesNames.map { .init(stringLiteral: $0) } + [
    // Dependencies that cannot be evaluated from name
]

let thirdPartyPackageDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.0"),
    .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.5.0"),
]

let thirdPartyTargetDependencies: [PackageDescription.Target.Dependency] = [
    "DeviceKit",
]

let packageDependencies = localPackageDependencies + thirdPartyPackageDependencies

let targetDependencies = localTargetDependencies + thirdPartyTargetDependencies

let swiftLintPlugin: PackageDescription.Target.PluginUsage = .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")

// MARK: - Package

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
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "Routely",
            dependencies: targetDependencies,
            plugins: [swiftLintPlugin]
        ),
    ]
)
