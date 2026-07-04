// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwDesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SwDesignSystem", targets: ["SwDesignSystem"]),
    ],
    targets: [
        .target(name: "SwDesignSystem", path: "Sources"),
        .testTarget(name: "SwDesignSystemTests", dependencies: ["SwDesignSystem"]),
    ]
)
