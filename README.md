# NamedPoint

A package to provide named points. Just say `.top(.left)` or `.topLeft` and it will work on all platforms in all situations - we take care of the inconsistencies of for you.

```swift
let screen = CGRect(x: 0, y: 0, width: 3440, height: 1440)
let point = screen.point(at: .top(.right))
```

By introducing named points we were also able to provide an alignment API:

```swift
let frame = CGRect(aligned: .bottom(.left), inside: screen, size: size)
```

As well as API to create an aspectFit frame:

```swift
AspectRatio(width: 16, height: 9).aspectFit(inside: screen)
```

API to create an aspectFill frame:

```swift
AspectRatio(width: 4, height: 3).aspectFill(inside: screen)
```

## Quick Start

Include the dependency in your Package.swift file:

```swift
.package(url: "https://github.com/ollieatkinson/NamedPoint", .branch("master"))
```
