//
//  CGPoint.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGPoint {
    @inlinable public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint { .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    @inlinable public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint { .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
}

extension CGPoint {
    @inlinable public func scaled(to factor: CGFloat, relativeTo point: CGPoint) -> CGPoint {
        self + (point - self) * (1 - factor)
    }
}
