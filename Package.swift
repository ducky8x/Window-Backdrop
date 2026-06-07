// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WindowBackdrop",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "WindowBackdrop", targets: ["WindowBackdrop"])
    ],
    targets: [
        .executableTarget(
            name: "WindowBackdrop",
            path: "Sources/WindowBackdrop"
        )
    ]
)
