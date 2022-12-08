import SwiftUI

public extension EdgeInsets {
    var vertical: CGFloat { top + bottom }
    var horizontal: CGFloat { leading + trailing }
}
