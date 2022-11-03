import SwiftUI

// MARK: - Corners

extension CGRect {
    public var center: CGPoint { CGPoint(x: midX, y: midY) }
    public var topLeft: CGPoint { origin }
    public var centerTop: CGPoint { CGPoint(x: midX, y: minY) }
    public var topRight: CGPoint { CGPoint(x: maxX, y: minY) }
    public var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    public var centerBottom: CGPoint { CGPoint(x: midX, y: maxY) }
    public var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }
    
    public var corners: [CGPoint] {
        [topLeft, topRight, bottomLeft, bottomRight]
    }
}

// MARK: - Contains Point

extension CGRect {
    public func contains(anyOf points: [CGPoint]) -> Bool {
        guard points.count > 0 else { return false }
        return points.first { contains($0) } != nil
    }
    
    public func contains(allOf points: [CGPoint]) -> Bool {
        guard points.count > 0 else { return true }
        return points.first { !contains($0) } == nil
    }
}

// MARK: - Init by size

extension CGRect {
    public init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
}

// MARK: - Insets

extension CGRect {
    public func inset(by edgeInsets: EdgeInsets) -> CGRect {
        CGRect(
            x: minX + edgeInsets.leading,
            y: minY + edgeInsets.top,
            width: width - edgeInsets.trailing - edgeInsets.leading,
            height: height - edgeInsets.bottom - edgeInsets.top
        )
    }
    
    public func inset(by value: CGFloat) -> CGRect {
        let insets = EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
        return inset(by: insets)
    }
}

// MARK: - Offset

extension CGRect {
    public func offset(by delta: CGPoint) -> CGRect {
        offset(x: delta.x, y: delta.y)
    }
    
    public func offset(x: CGFloat=0, y: CGFloat=0) -> CGRect {
        CGRect(origin: origin.offset(x: x, y: y), size: size)
    }
}

// MARK: - Debug

extension CGRect: CustomStringConvertible {
    public var description: String {
        "{origin: \(origin), size: \(size)}"
    }
}

// MARK: - Extension

extension CGRect {
    public var bounds: CGRect {
        CGRect(origin: .zero, size: size)
    }
}

