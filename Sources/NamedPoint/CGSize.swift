//
//  CGSize.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGSize {
    @inlinable public func point(at alignment: NamedAlignment, from origin: Geometry.Origin = .os) -> CGPoint {
        point(at: alignment.namedPoint, from: origin)
    }
    @inlinable public func point(at namedPoint: NamedPoint, from origin: Geometry.Origin = .os) -> CGPoint {
        point(anchor: namedPoint.anchor, from: origin)
    }
    @inlinable public func point(anchor: CGPoint, from origin: Geometry.Origin = .os) -> CGPoint {
        .init(x: width * anchor.x, y: height * origin.anchor(y: anchor.y))
    }
}
