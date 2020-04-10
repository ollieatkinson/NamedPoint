//
//  CGSize.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

public typealias AspectRatio = CGSize

extension AspectRatio {
    @inlinable public func aspectFit(inside rect: CGRect) -> CGRect { .init(aspectFit: self, inside: rect) }
    @inlinable public func aspectFill(inside rect: CGRect) -> CGRect { .init(aspectFill: self, inside: rect) }
}

extension CGSize {
    @inlinable public func rect(aligned alignment: Alignment, inside rect: CGRect, padding: CGFloat = .zero) -> CGRect {
        .init(anchor: alignment, at: rect.point(at: alignment) + (padding * alignment.spacing), size: self)
    }
    @inlinable public func rect(aligned alignment: Alignment, outside rect: CGRect, padding: CGFloat = .zero) -> CGRect {
        .init(anchor: alignment.opposite, at: rect.point(at: alignment) + (padding * alignment.opposite.spacing), size: self)
    }
}

extension CGSize {
    @inlinable public func point(at alignment: Alignment, from origin: Geometry.Origin = .os) -> CGPoint {
        point(at: alignment.namedPoint, from: origin)
    }
    @inlinable public func point(at namedPoint: NamedPoint, from origin: Geometry.Origin = .os) -> CGPoint {
        point(anchor: namedPoint.anchor, from: origin)
    }
    @inlinable public func point(anchor: CGPoint, from origin: Geometry.Origin = .os) -> CGPoint {
        .init(x: width * anchor.x, y: height * origin.anchor(y: anchor.y))
    }
}

extension CGSize {
    @inlinable public static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }
    @inlinable public static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
    }
    @inlinable public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    @inlinable public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}

extension CGSize {
    @inlinable public var abs: CGSize {
        .init(width: width.abs, height: height.abs)
    }
    @inlinable public init(square length: Int) {
        self.init(width: length, height: length)
    }
}

extension CGSize {
    @inlinable public static func * (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.width * rhs.x, y: lhs.height * rhs.y)
    }
    @inlinable public static func / (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.width / rhs.x, y: lhs.height / rhs.y)
    }
    @inlinable public static func + (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.width + rhs.x, y: lhs.height + rhs.y)
    }
    @inlinable public static func - (lhs: CGSize, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.width - rhs.x, y: lhs.height - rhs.y)
    }
}

extension CGPoint {
    @inlinable public static func * (lhs: CGPoint, rhs: CGSize) -> CGPoint { rhs * lhs }
    @inlinable public static func / (lhs: CGPoint, rhs: CGSize) -> CGPoint { rhs / lhs }
    @inlinable public static func + (lhs: CGPoint, rhs: CGSize) -> CGPoint { rhs + lhs }
    @inlinable public static func - (lhs: CGPoint, rhs: CGSize) -> CGPoint { rhs - lhs }
}

extension CGSize {
    
    @inlinable public func scalingFactor(toFit size: CGSize) -> CGFloat { min(size.abs.width / abs.width, size.abs.height / abs.height) }
    @inlinable public func scalingFactor(toFill size: CGSize) -> CGFloat { max(size.abs.width / abs.width, size.abs.height / abs.height) }
    
    @inlinable public func scaled(toFit size: CGSize) -> CGSize { scalingFactor(toFit: size) * abs }
    @inlinable public func scaled(toFill size: CGSize) -> CGSize { scalingFactor(toFill: size) * abs }
    
    @inlinable public func scaled(to factor: CGFloat) -> CGSize { self * factor }
    
}

extension SignedNumeric where Self: Comparable {
    @inlinable public var abs: Self { Swift.abs(self) }
}
