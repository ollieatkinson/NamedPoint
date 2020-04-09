//
//  Alignment.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

public enum Alignment: Codable, Hashable {
    
    public enum Horizontal: String, Codable {
        case left, center, right
    }

    public enum Vertical: String, Codable {
        case top, middle, bottom
    }

    case top(Horizontal)
    case bottom(Horizontal)
    case left(Vertical)
    case right(Vertical)
    case center
    
}

extension Alignment {
    
    public var namedPoint: NamedPoint { .init(self) }
    public var anchor: CGPoint { namedPoint.anchor }
    
    public var opposite: Alignment {
        switch self {
        case let .top(h):    return .bottom(h)
        case let .bottom(h): return .top(h)
        case     .center:    return .center
        case let .left(v):   return .right(v)
        case let .right(v):  return .left(v)
        }
    }
    
    public var spacing: CGSize {
        switch self {
        case .top:    return .init(width: 0, height: Geometry.isFlipped ? 1 : -1)
        case .bottom: return .init(width: 0, height: Geometry.isFlipped ? -1 : 1)
        case .center: return .init(width: 0, height: 0)
        case .left:   return .init(width: 1, height: 0)
        case .right:  return .init(width: -1, height: 0)
        }
    }
    
}

extension Alignment {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try container.decode(NamedPoint.self).alignment
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(namedPoint)
    }
}

extension Alignment.Horizontal {
    var x: CGFloat {
        switch self {
        case .left:   return 0
        case .center: return 0.5
        case .right:  return 1
        }
    }
}

extension Alignment.Vertical {
    var y: CGFloat {
        switch self {
        case .top:
            switch Geometry.origin {
            case .topLeft:    return 0
            case .bottomLeft: return 1
            }
        case .bottom:
            switch Geometry.origin {
            case .topLeft:    return 1
            case .bottomLeft: return 0
            }
        case .middle: return 0.5
        }
    }
}
