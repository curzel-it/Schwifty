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
    static let oneByOne = CGSize(square: 1)
}

public extension CGSize {
    var center: CGPoint {
        CGPoint(x: width/2, y: height/2)
    }
    
    func area() -> CGFloat {
        width * height
    }
    
    func diagonal() -> CGFloat {
        sqrt(pow(width, 2) + pow(height, 2))
    }
    
    func oppositeSign() -> CGSize {
        CGSize(width: -width, height: -height)
    }
    
    func scaled(_ scalar: CGFloat) -> CGSize {
        CGSize(width: width * scalar, height: height * scalar)
    }
}

public func min(_ sizes: CGSize...) -> CGSize? {
    sizes.sorted { $0.area() < $1.area() }.first
}

public func max(_ sizes: CGSize...) -> CGSize? {
    sizes.sorted { $0.area() > $1.area() }.first
}

