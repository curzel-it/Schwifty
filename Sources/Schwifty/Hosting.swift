import SwiftUI

#if os(macOS)
    import AppKit

    public extension View {
        func hosted() -> NSHostingView<Self> {
            NSHostingView(rootView: self)
        }
    }
#else
    import UIKit

    public extension View {
        func hosted() -> UIHostingController<Self> {
            UIHostingController(rootView: self)
        }
    }
#endif
