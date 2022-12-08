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
