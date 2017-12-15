// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "BitArray",
    products: [
        .library(
            name: "BitArray",
            targets: ["BitArray"]),
    ],
    targets: [
        .target(
            name: "BitArray",
            dependencies: []),
        .testTarget(
            name: "BitArrayTests",
            dependencies: ["BitArray"]),
    ]
)
