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
        size.point(anchor: anchor, from: origin)
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
    public var anchor: CGPoint { .init(x: horizontal.x, y: vertical.y) }
}
