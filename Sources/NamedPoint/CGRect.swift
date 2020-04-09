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
    @inlinable public init(aspectRatio: CGSize, inside rect: CGRect) {
        self.init(aligned: .center, inside: rect, size: aspectRatio.scaled(toFit: rect.size))
    }
    @inlinable public init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
    @inlinable public init(square length: Int) {
        self.init(origin: .zero, size: .init(square: length))
    }
}
