# NamedPoint

A package to provide names for points in a frame.

```swift
public enum NamedPoint: String, Codable, Hashable {
    case topLeft,    topCenter,    topRight
    case middleLeft, middleCenter, middleRight
    case bottomLeft, bottomCenter, bottomRight
}
```

For example, just say `.top(.left)` or `.topLeft` and it will work on all platforms in all situations - we take care of the inconsistencies of for you.

```swift
let screen = CGRect(x: 0, y: 0, width: 3440, height: 1440)
let point = screen.point(at: .top(.right))
```

## Quick Start

Include the dependency in your Package.swift file:

```swift
.package(url: "https://github.com/ollieatkinson/NamedPoint", .branch("master"))
```
