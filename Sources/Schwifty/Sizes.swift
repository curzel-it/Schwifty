import SwiftUI

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "(w: \(Int(width)), h: \(Int(height)))"
    }
}

public extension CGSize {
    init(square value: CGFloat) {
        self.init(width: value, height: value)
    }
}

public extension CGSize {
    func oppositeSign() -> CGSize {
        CGSize(width: -width, height: -height)
    }
}

public extension CGSize {
    static let oneByOne = CGSize(square: 1)
}

public extension CGSize {
    func area() -> CGFloat {
        width * height
    }
}

public func min(_ sizes: CGSize...) -> CGSize? {
    sizes.sorted { $0.area() < $1.area() }.first
}

public func max(_ sizes: CGSize...) -> CGSize? {
    sizes.sorted { $0.area() > $1.area() }.first
}

