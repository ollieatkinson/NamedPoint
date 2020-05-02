//
//  CGPoint.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGPoint {
    @inlinable static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint { .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    @inlinable static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint { .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
}
