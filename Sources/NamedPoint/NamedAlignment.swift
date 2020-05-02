//
//  NamedAlignment.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

public enum NamedAlignment: Hashable {
    
    public enum Horizontal: String, Codable {
        case left, center, right
    }

    public enum Vertical: String, Codable {
        case top, middle, bottom
    }

    case top(Horizontal)
    case middle(Horizontal)
    case bottom(Horizontal)
    
    case left(Vertical)
    case right(Vertical)
    
    case center
    
}

extension NamedAlignment {
    public var namedPoint: NamedPoint { .init(self) }
}

extension NamedAlignment.Horizontal {
    public var x: CGFloat {
        switch self {
        case .left:   return 0
        case .center: return 0.5
        case .right:  return 1
        }
    }
}

extension NamedAlignment.Vertical {
    public var y: CGFloat {
        switch self {
        case .top:    return Geometry.isFlipped ? 0 : 1
        case .bottom: return Geometry.isFlipped ? 1 : 0
        case .middle: return 0.5
        }
    }
}
