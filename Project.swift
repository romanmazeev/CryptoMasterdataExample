import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project(
    name: "CryptoMasterdataExample",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.33.1")),
        .remote(url: "https://github.com/apple/swift-log.git", requirement: .upToNextMajor(from: "1.4.2")),
        .remote(url: "https://github.com/kean/NukeUI.git", requirement: .upToNextMajor(from: "0.8.0")),
        .remote(url: "https://github.com/SVGKit/SVGKit.git", requirement: .upToNextMajor(from: "3.0.0"))
        
    ],
    targets: [
        Target(
            name: "CryptoMasteradataExample",
            platform: .iOS,
            product: .app,
            bundleId: "com.romanmazeev.CryptoMasterdataExample",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [
                "Sources/**"
            ],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "Logging"),
                .package(product: "NukeUI"),
                .package(product: "SVGKit")
            ]
        )
    ]
)
