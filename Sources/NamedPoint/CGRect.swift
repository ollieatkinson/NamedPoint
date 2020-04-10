//
//  CGRect.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGRect {
    @inlinable public init(aligned alignment: Alignment, inside rect: CGRect, size: CGSize, padding: CGFloat = .zero) {
        self.init(anchor: alignment, at: rect.point(at: alignment) + padding * alignment.spacing, size: size)
    }
    @inlinable public init(aligned alignment: Alignment, outside rect: CGRect, size: CGSize, padding: CGFloat = .zero) {
        self.init(anchor: alignment.opposite, at: rect.point(at: alignment) + padding * alignment.opposite.spacing, size: size)
    }
}

extension CGRect {
    @inlinable public init(anchor alignment: Alignment, at position: CGPoint, size: CGSize) {
        self.init(anchor: alignment.anchor, at: position, size: size)
    }
    @inlinable public init(anchor namedPoint: NamedPoint, at position: CGPoint, size: CGSize) {
        self.init(anchor: namedPoint.anchor, at: position, size: size)
    }
    @inlinable public init(anchor: CGPoint, at position: CGPoint, size: CGSize) {
        self.init(origin: position - size * anchor, size: size)
    }
    @inlinable public func point(at alignment: Alignment, from geometryOrigin: Geometry.Origin = .os) -> CGPoint {
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
    @inlinable public init(aspectFit: CGSize, inside rect: CGRect) {
        self.init(aligned: .center, inside: rect, size: aspectFit.scaled(toFit: rect.size))
    }
    @inlinable public init(aspectFill: CGSize, inside rect: CGRect) {
        self.init(aligned: .center, inside: rect, size: aspectFill.scaled(toFill: rect.size))
    }
    @inlinable public init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
    @inlinable public init(square length: Int) {
        self.init(origin: .zero, size: .init(square: length))
    }
}

extension CGRect {
    @inlinable public func scaled(to factor: CGFloat, anchor alignment: Alignment = .center) -> CGRect {
        scaled(to: factor, anchor: alignment.anchor)
    }
    @inlinable public func scaled(to factor: CGFloat, anchor namedPoint: NamedPoint = .middleCenter) -> CGRect {
        scaled(to: factor, anchor: namedPoint.anchor)
    }
    @inlinable public func scaled(to factor: CGFloat, anchor: CGPoint) -> CGRect {
        .init(origin: origin.scaled(to: factor, relativeTo: point(anchor: anchor)), size: size.scaled(to: factor))
    }
}

extension CGRect {

    public var topLeft: CGPoint { point(at: .topLeft) }
    public var topCenter: CGPoint { point(at: .topCenter) }
    public var topRight: CGPoint { point(at: .topRight) }
    
    public var middleLeft: CGPoint { point(at: .middleLeft) }
    public var center: CGPoint { point(at: .center) }
    public var middleRight: CGPoint { point(at: .middleRight) }
    
    public var bottomLeft: CGPoint { point(at: .bottomLeft) }
    public var bottomCenter: CGPoint { point(at: .bottomCenter) }
    public var bottomRight: CGPoint { point(at: .bottomRight) }
    
}
