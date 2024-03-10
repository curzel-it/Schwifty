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
            x: origin.x + edgeInsets.leading,
            y: origin.y + edgeInsets.top,
            width: width - edgeInsets.trailing - edgeInsets.leading,
            height: height - edgeInsets.bottom - edgeInsets.top
        )
    }

    func inset(by value: CGFloat) -> CGRect {
        let insets = EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
        return inset(by: insets)
    }
}

#if os(macOS)
public extension CGRect {
    func inset(by insets: NSEdgeInsets) -> CGRect {
        CGRect(
            x: origin.x + insets.left,
            y: origin.y + insets.top,
            width: size.width - insets.left - insets.right,
            height: size.height - insets.top - insets.bottom
        )
    }
}
#endif

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

// MARK: - Geometry

public extension CGRect {
    var bounds: CGRect {
        CGRect(origin: .zero, size: size)
    }
    
    func diagonal() -> CGFloat {
        size.diagonal()
    }
    
    func area() -> CGFloat {
        size.area()
    }
    
    func scaled(_ scalar: CGFloat) -> CGRect {
        CGRect(origin: origin.scaled(scalar), size: size.scaled(scalar))
    }
}

// MARK: - Smallest Enclosing Rect

public extension Array where Element == CGRect {
    func smallestEnclosingRectangle() -> CGRect? {
        guard !isEmpty else { return nil }
                
        var minX = self[0].minX
        var maxX = self[0].maxX
        var minY = self[0].minY
        var maxY = self[0].maxY

        for rect in self.dropFirst() {
            minX = Swift.min(minX, rect.minX)
            maxX = Swift.max(maxX, rect.maxX)
            minY = Swift.min(minY, rect.minY)
            maxY = Swift.max(maxY, rect.maxY)
        }
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}

