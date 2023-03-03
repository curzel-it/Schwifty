import SwiftUI

public struct Screen {
    public let localizedName: String?
    public let frame: CGRect
    
    public var bounds: CGRect { frame.bounds }
}

#if os(macOS)
extension Screen {
    init?(from screen: NSScreen?) {
        guard let screen else { return nil }
        self.localizedName = screen.localizedName
        self.frame = screen.frame
    }
}
#else
extension Screen {
    init?(from screen: UIScreen?) {
        guard let screen else { return nil }
        self.localizedName = "n/a"
        self.frame = screen.bounds
    }
}
#endif

public extension Screen {
    static var main: Screen? {
        #if os(macOS)
        return Screen(from: NSScreen.main)
        #else
        return Screen(from: UIScreen.main)
        #endif
    }
    
    static var screens: [Screen] {
#if os(macOS)
        return NSScreen.screens.compactMap { Screen(from: $0) }
#else
        guard let screen = Screen.main else { return [] }
        return [screen]
#endif
    }
}
