#if os(macOS)
    import AppKit
    import SwiftUI

    public extension NSWindow {
        func show(_ sender: Any? = nil) {
            guard !isVisible else { return }
            NSWindowController(window: self).showWindow(sender)
        }
    }
#endif
