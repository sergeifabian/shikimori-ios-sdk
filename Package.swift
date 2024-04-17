// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ShikimoriSDK",
  platforms: [
    .iOS(.v14)
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
