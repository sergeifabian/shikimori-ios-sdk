// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ShikimoriSDK",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "ShikimoriSDK",
      targets: ["ShikimoriSDK"]
    ),
  ],
  targets: [
    .target(
      name: "ShikimoriSDK"
    ),
    .testTarget(
      name: "ShikimoriSDKTests",
      dependencies: ["ShikimoriSDK"]
    ),
  ]
)
