//
//  NamedPoint.swift
//
//
//  Created by Oliver Atkinson on 15/03/2020.
//

import CoreGraphics

public enum NamedPoint: String, Codable, Hashable {
    case topLeft,    topCenter,    topRight
    case middleLeft, middleCenter, middleRight
    case bottomLeft, bottomCenter, bottomRight
}

extension NamedPoint {
    public func point(in frame: CGRect, from origin: Geometry.Origin = .os) -> CGPoint {
        frame.point(anchor: anchor, from: origin)
    }
    public func point(in size: CGSize, from origin: Geometry.Origin = .os) -> CGPoint {
        CGRect(size: size).point(anchor: anchor, from: origin)
    }
}

extension NamedPoint {
    init(_ alignment: Alignment) {
        switch alignment {
        case let .top(h):
            switch h {
            case .left:   self = .topLeft
            case .center: self = .topCenter
            case .right:  self = .topRight
            }
        case let .bottom(h):
            switch h {
            case .left:   self = .bottomLeft
            case .center: self = .bottomCenter
            case .right:  self = .bottomRight
            }
        case .center:
            self = .middleCenter
        case let .left(v):
            switch v {
            case .top:    self = .topLeft
            case .middle: self = .middleLeft
            case .bottom: self = .bottomLeft
            }
        case let .right(v):
            switch v {
            case .top:    self = .topRight
            case .middle: self = .middleRight
            case .bottom: self = .bottomRight
            }
        }
    }
    var alignment: Alignment {
        switch self {
        case .topLeft:      return .top(.left)
        case .topCenter:    return .top(.center)
        case .topRight:     return .top(.right)
        case .middleLeft:   return .left(.middle)
        case .middleCenter: return .center
        case .middleRight:  return .right(.middle)
        case .bottomLeft:   return .bottom(.left)
        case .bottomCenter: return .bottom(.center)
        case .bottomRight:  return .bottom(.right)
        }
    }
}

extension NamedPoint {
    public var horizontal: Alignment.Horizontal {
        switch self {
        case .topLeft,   .middleLeft,   .bottomLeft:   return .left
        case .topCenter, .middleCenter, .bottomCenter: return .center
        case .topRight,  .middleRight,  .bottomRight:  return .right
        }
    }
    public var vertical: Alignment.Vertical {
        switch self {
        case .topLeft,    .topCenter,    .topRight:    return .top
        case .middleLeft, .middleCenter, .middleRight: return .middle
        case .bottomLeft, .bottomCenter, .bottomRight: return .bottom
        }
    }
    public var anchor: CGPoint {
        .init(x: horizontal.x, y: vertical.y)
    }
}

#if swift(>=5.2)

extension CGRect {
    public var top: Top { Top(frame: self) }
    public var bottom: Bottom { Bottom(frame: self) }
    public var right: Right { Right(frame: self) }
    public var left: Left { Left(frame: self) }
    public var center: CGPoint { point(at: .center) }
}

protocol DynamicMemberAlignment {
    var frame: CGRect { get }
}

extension DynamicMemberAlignment {
    subscript(dynamicMember keyPath: KeyPath<Self, Alignment>) -> CGPoint {
        frame.point(at: self[keyPath: keyPath])
    }
}

protocol DynamicMemberHorizontalAlignment: DynamicMemberAlignment {
    var left: Alignment { get }
    var center: Alignment { get }
    var right: Alignment { get }
}

protocol DynamicMemberVerticalAlignment: DynamicMemberAlignment {
    var top: Alignment { get }
    var middle: Alignment { get }
    var bottom: Alignment { get }
}

@dynamicMemberLookup
public struct Top: DynamicMemberHorizontalAlignment {
    public let frame: CGRect
    public let left: Alignment = .top(.left)
    public let center: Alignment = .top(.center)
    public let right: Alignment = .top(.right)
}

@dynamicMemberLookup
public struct Left: DynamicMemberVerticalAlignment {
    public let frame: CGRect
    public let top: Alignment = .left(.top)
    public let middle: Alignment = .left(.middle)
    public let bottom: Alignment = .left(.bottom)
}

@dynamicMemberLookup
public struct Right: DynamicMemberVerticalAlignment {
    public let frame: CGRect
    public let top: Alignment = .right(.top)
    public let middle: Alignment = .right(.middle)
    public let bottom: Alignment = .right(.bottom)
}

@dynamicMemberLookup
public struct Bottom: DynamicMemberHorizontalAlignment {
    public let frame: CGRect
    public let left: Alignment = .bottom(.left)
    public let center: Alignment = .bottom(.center)
    public let right: Alignment = .bottom(.right)
}

#endif
