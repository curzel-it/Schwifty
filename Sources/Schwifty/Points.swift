import SwiftUI

// MARK: - Distance

public extension CGPoint {
    func distance(from other: CGPoint) -> CGFloat {
        sqrt(pow(other.x - x, 2) + pow(other.y - y, 2))
    }
}

// MARK: - Angles

public extension CGPoint {
    func angle(to other: CGPoint) -> CGFloat {
        let rad = atan2(other.y - y, other.x - x)
        if rad >= 0 { return rad }
        return rad + 2 * .pi
    }
}

// MARK: - Offset

public extension CGPoint {
    func offset(by delta: CGPoint) -> CGPoint {
        return offset(x: delta.x, y: delta.y)
    }

    func offset(by delta: CGSize) -> CGPoint {
        return offset(x: delta.width, y: delta.height)
    }

    func offset(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}

// MARK: - Points on Rect

public extension CGPoint {
    func isOnEdge(of rect: CGRect) -> Bool {
        if x == rect.minX || x == rect.maxX {
            return rect.minY <= y && y <= rect.maxY
        }
        if y == rect.minY || y == rect.maxY {
            return rect.minX <= x && x <= rect.maxX
        }
        return false
    }
}

// MARK: - Init from Vector

public extension CGPoint {
    init(vector: CGVector, radius: CGFloat = 1, offset: CGPoint = .zero) {
        self.init(
            x: radius * vector.dx + offset.x,
            y: radius * vector.dy + offset.y
        )
    }
}

// MARK: - String Convertible

extension CGPoint: CustomStringConvertible {
    public var description: String {
        let xVal = String(format: "%0.2f", x)
        let yVal = String(format: "%0.2f", y)
        return "(x: \(xVal), y: \(yVal))"
    }
}

// MARK: - Geometry

public extension CGPoint {
    func scaled(_ scalar: CGFloat) -> CGPoint {
        CGPoint(x: x * scalar, y: y * scalar)
    }
}
