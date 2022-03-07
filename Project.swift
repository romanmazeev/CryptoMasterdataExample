import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project(
    name: "BitpandaTest",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.33.1")),
        .remote(url: "https://github.com/apple/swift-log.git", requirement: .upToNextMajor(from: "1.4.2"))
    ],
    targets: [
        Target(
            name: "BitpandaTest",
            platform: .iOS,
            product: .app,
            bundleId: "com.romanmazeev.BitpandaTest",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [
                "Sources/**"
            ],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "Logging")
            ]
        )
    ]
)
