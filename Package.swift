// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// IMPORTANT: IF YOU CHANGE THE BELOW, PLEASE ALSO CHANGE THE LARGE FATALERROR()
// MESSAGE IN FILE.SWIFT TO MATCH THE NEW SWIFT VERSION.

let swiftSyntaxVersion = Package.Dependency.Requirement.exactItem("0.50600.1")

let package = Package(
    name: "Sitrep",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .library(name: "SitrepCore", targets: ["SitrepCore"])
    ],
    dependencies: [
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", swiftSyntaxVersion),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.4")
    ],
    targets: [
        .executableTarget(name: "Sitrep", dependencies: ["SitrepCore",
                                               .product(name: "ArgumentParser",
                                                        package: "swift-argument-parser")]),
        .target(name: "SitrepCore", dependencies: ["SwiftSyntax",
                                                   "Yams",
                                                   .product(name: "ArgumentParser",
                                                            package: "swift-argument-parser")]),
        .testTarget(name: "SitrepCoreTests", dependencies: ["SitrepCore"], exclude: ["Inputs"])
    ]
)
