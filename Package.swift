// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MagicBattery",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "MagicBattery",
            path: "Sources/MagicBattery"
        )
    ]
)
