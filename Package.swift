// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NFTExplorerService",
    platforms: [
        // Support macos and ios
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NFTExplorerService",
            targets: ["NFTExplorerService"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NFTExplorerService",
            dependencies: ["SwiftProtobuf",.product(name: "GRPC", package: "grpc-swift")],
            resources: [
                .copy("NFTExplorerProto/nft_explorer.proto")
            ]
        ),
        .testTarget(
            name: "NFTExplorerServiceTests",
            dependencies: ["NFTExplorerService"]),
    ]
)
