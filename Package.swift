// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Dependencies

let localDependenciesNames: [String] = [
]

let localPackageDependencies: [PackageDescription.Package.Dependency] = localDependenciesNames.map { .package(path: "../\($0)") }

let localTargetDependencies: [PackageDescription.Target.Dependency] = localDependenciesNames.map { .init(stringLiteral: $0) } + [
    // Dependencies that cannot be evaluated from name
]

let thirdPartyPackageDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.0"),
    .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.5.0"),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.4.3"),
]

let thirdPartyTargetDependencies: [PackageDescription.Target.Dependency] = [
    "DeviceKit",
    .product(name: "Factory", package: "Factory"),
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
            name: "RoutingInterfaces",
            targets: ["RoutingInterfaces"]
        ),
        .library(
            name: "Routing",
            targets: ["Routing"]
        ),
        .library(
            name: "DeepLinking",
            targets: ["DeepLinking"]
        ),
    ],
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "DeepLinking",
            dependencies: ["RoutingInterfaces", "Factory"],
            plugins: [swiftLintPlugin]
        ),
        .target(
            name: "Routing",
            dependencies: ["DeepLinking", "RoutingInterfaces", "DeviceKit"],
            plugins: [swiftLintPlugin]
        ),
        .target(
            name: "RoutingInterfaces",
            dependencies: [],
            plugins: [swiftLintPlugin]
        ),
    ]
)
