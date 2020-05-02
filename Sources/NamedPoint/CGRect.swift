//
//  CGRect.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGRect {
    @inlinable public func point(at alignment: NamedAlignment, from geometryOrigin: Geometry.Origin = .os) -> CGPoint {
        point(at: alignment.namedPoint, from: geometryOrigin)
    }
    @inlinable public func point(at namedPoint: NamedPoint, from geometryOrigin: Geometry.Origin = .os) -> CGPoint {
        point(anchor: namedPoint.anchor, from: geometryOrigin)
    }
    @inlinable public func point(anchor: CGPoint, from geometryOrigin: Geometry.Origin = .os) -> CGPoint {
        origin + size.point(anchor: anchor, from: geometryOrigin)
    }
}

extension CGRect {

    public var topLeft: CGPoint { point(at: .topLeft) }
    public var topCenter: CGPoint { point(at: .topCenter) }
    public var topRight: CGPoint { point(at: .topRight) }
    
    public var middleLeft: CGPoint { point(at: .middleLeft) }
    public var center: CGPoint { point(at: .middleCenter) }
    public var middleRight: CGPoint { point(at: .middleRight) }
    
    public var bottomLeft: CGPoint { point(at: .bottomLeft) }
    public var bottomCenter: CGPoint { point(at: .bottomCenter) }
    public var bottomRight: CGPoint { point(at: .bottomRight) }
    
}
