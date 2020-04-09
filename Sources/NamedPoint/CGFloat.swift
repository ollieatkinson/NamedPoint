//
//  CGFloat.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

extension CGFloat {
    @inlinable public static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
        .init(width: lhs * rhs.width, height: lhs * rhs.height)
    }
    @inlinable public static func / (lhs: CGFloat, rhs: CGSize) -> CGSize {
        .init(width: lhs / rhs.width, height: lhs / rhs.height)
    }
    @inlinable public static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        .init(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    @inlinable public static func / (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        .init(x: lhs / rhs.x, y: lhs / rhs.y)
    }
}

extension CGSize {
    @inlinable public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize { rhs * lhs }
    @inlinable public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize { rhs / lhs }
}

extension CGPoint {
    @inlinable public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint { rhs * lhs }
    @inlinable public static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint { rhs / lhs }
}
