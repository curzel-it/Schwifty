import SwiftUI

public extension EdgeInsets {
    var vertical: CGFloat { top + bottom }
    var horizontal: CGFloat { leading + trailing }
}

#if os(macOS)
public extension NSEdgeInsets {
    func verticalOnly() -> NSEdgeInsets {
        NSEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    func horizontalOnly() -> NSEdgeInsets {
        NSEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
}
#endif
