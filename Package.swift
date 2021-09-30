// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebladeECSDemo",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SDL", url: "git@github.com:ARPGLTD/SDL.git", .branch("SwiftPackage")),
        .package(name: "FirebladeECS", url: "https://github.com/fireblade-engine/ecs.git", from: "0.17.4"),
        .package(name: "FirebladeMath", url: "https://github.com/fireblade-engine/math.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "SDLKit", dependencies: ["SDL"]),
        .target(
            name: "Particles",
            dependencies: ["FirebladeECS", "SDL", "SDLKit"]),
        .target(
            name: "Asteroids",
            dependencies: ["FirebladeECS", "SDL", "SDLKit", "FirebladeMath", "AsteroidsGameLibrary"],
            exclude: ["Resources/source.txt"],
            resources: [.copy("Resources/asteroid.wav"), .copy("Resources/ship.wav"), .copy("Resources/shoot.wav")]),
        .target(name: "AsteroidsGameLibrary",
                dependencies: ["FirebladeMath"])
    ]
)
