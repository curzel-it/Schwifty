import SwiftUI

// MARK: - Corners

public extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
    var topLeft: CGPoint { origin }
    var centerTop: CGPoint { CGPoint(x: midX, y: minY) }
    var topRight: CGPoint { CGPoint(x: maxX, y: minY) }
    var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    var centerBottom: CGPoint { CGPoint(x: midX, y: maxY) }
    var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }

    var corners: [CGPoint] {
        [topLeft, topRight, bottomLeft, bottomRight]
    }
}

public extension CGRect {
    func area() -> CGFloat {
        size.area()
    }
}

// MARK: - Contains Point

public extension CGRect {
    func contains(anyOf points: [CGPoint]) -> Bool {
        guard points.count > 0 else { return false }
        return points.first { contains($0) } != nil
    }

    func contains(allOf points: [CGPoint]) -> Bool {
        guard points.count > 0 else { return true }
        return points.first { !contains($0) } == nil
    }
}

// MARK: - Contains Rect

public extension CGRect {
    func contains(rect other: CGRect) -> Bool {
        other.corners
            .map { contains($0) || $0.isOnEdge(of: self) }
            .allSatisfy { $0 }
    }
}

// MARK: - Init by size

public extension CGRect {
    init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
    
    init(square: CGFloat) {
        self.init(size: CGSize(square: square))
    }
}

// MARK: - Insets

public extension CGRect {
    func inset(by edgeInsets: EdgeInsets) -> CGRect {
        CGRect(
            x: minX + edgeInsets.leading,
            y: minY + edgeInsets.top,
            width: width - edgeInsets.trailing - edgeInsets.leading,
            height: height - edgeInsets.bottom - edgeInsets.top
        )
    }

    func inset(by value: CGFloat) -> CGRect {
        let insets = EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
        return inset(by: insets)
    }
}

// MARK: - Offset

public extension CGRect {
    func offset(by delta: CGPoint) -> CGRect {
        offset(x: delta.x, y: delta.y)
    }
    
    func offset(by delta: CGSize) -> CGRect {
        offset(x: delta.width, y: delta.height)
    }

    func offset(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
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

public extension CGRect {
    var bounds: CGRect {
        CGRect(origin: .zero, size: size)
    }
}
