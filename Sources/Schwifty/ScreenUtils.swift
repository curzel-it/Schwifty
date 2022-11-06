import SwiftUI

public struct Screen {
    public static var main: Screen {
#if os(macOS)
        let frame = NSScreen.main?.frame ?? .zero
        return Screen(bounds: CGRect(origin: .zero, size: frame.size))
#else
        return Screen(bounds: UIScreen.main.bounds)
#endif
    }
    
    public let bounds: CGRect
}
