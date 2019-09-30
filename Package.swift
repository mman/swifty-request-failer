// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swifty-request-failer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/SwiftyRequest.git", from: "2.2.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "swifty-request-failer",
            dependencies: ["SwiftyRequest", "HeliumLogger"]),
        .testTarget(
            name: "swifty-request-failerTests",
            dependencies: ["swifty-request-failer"]),
    ]
)
