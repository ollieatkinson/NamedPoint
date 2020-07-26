//
//  Geometry.swift
//  
//
//  Created by Oliver Atkinson on 06/04/2020.
//

import CoreGraphics

public enum Geometry: Hashable {

    public static let origin: Geometry.Origin = .os
    
    public static var isFlipped: Bool = {
#if os(macOS)
        return false
#else
        return true
#endif
    }()
    
}

extension Geometry {
    
    public enum Origin: String, Codable, Hashable {
        case topLeft
        case bottomLeft
    }
    
}

extension Geometry.Origin {
    
    public static var os: Geometry.Origin {
        Geometry.isFlipped ? .topLeft : .bottomLeft
    }
    
    public func anchor(y: CGFloat) -> CGFloat {
        switch self {
        case .topLeft:    return Geometry.isFlipped ? y : 1 - y
        case .bottomLeft: return Geometry.isFlipped ? 1 - y : y
        }
    }
    
}
