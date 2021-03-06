//
//  CGPointExtension.swift
//  Pods
//
//  Created by jesse on 2017/7/17.
//
//

import Foundation

// MARK: - Static Operators

extension CGPoint {
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    public static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    public static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    public static func *= (point: inout CGPoint, scalar: CGFloat) {
        point = point * scalar
    }

    public static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }

    public static func / (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }

    public static func /= (point: inout CGPoint, scalar: CGFloat) {
        point = point / scalar
    }
}
