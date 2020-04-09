//
//  CALayer.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

#if canImport(QuartzCore)

import QuartzCore

extension CALayer {

    @inlinable public var origin: Geometry.Origin {
        if Geometry.isFlipped {
            return isGeometryFlipped ? .bottomLeft : .topLeft
        } else {
            return isGeometryFlipped ? .topLeft : .bottomLeft
        }
    }
    
    @inlinable public func point(at alignment: Alignment) -> CGPoint {
        frame.point(at: alignment, from: origin)
    }
    @inlinable public func point(at namedPoint: NamedPoint) -> CGPoint {
        frame.point(at: namedPoint, from: origin)
    }
    @inlinable public func point(anchor: CGPoint) -> CGPoint {
        frame.point(anchor: anchor, from: origin)
    }
    
}

#endif

#if canImport(AppKit)

import AppKit

extension NSView {
    @inlinable public var origin: Geometry.Origin? { layer?.origin }
    @inlinable public func point(at alignment: Alignment) -> CGPoint? { layer?.point(at: alignment) }
    @inlinable public func point(at namedPoint: NamedPoint) -> CGPoint? { layer?.point(at: namedPoint) }
    @inlinable public func point(anchor: CGPoint) -> CGPoint? { layer?.point(anchor: anchor) }
}

#endif

#if canImport(UIKit)

import UIKit

extension UIView {
    @inlinable public var origin: Geometry.Origin { layer.origin }
    @inlinable public func point(at alignment: Alignment) -> CGPoint { layer.point(at: alignment) }
    @inlinable public func point(at namedPoint: NamedPoint) -> CGPoint { layer.point(at: namedPoint) }
    @inlinable public func point(anchor: CGPoint) -> CGPoint { layer.point(anchor: anchor) }
}

#endif
