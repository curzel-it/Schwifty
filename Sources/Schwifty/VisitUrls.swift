import Foundation

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

public extension URL {
    static func visit(url: URL) {
        #if os(macOS)
            NSWorkspace.shared.open(url)
        #else
            UIApplication.shared.open(url)
        #endif
    }

    static func visit(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URL.visit(url: url)
    }

    func visit() {
        URL.visit(url: self)
    }
}
