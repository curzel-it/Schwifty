//
// Schwifty.
// 

import SwiftUI

#if os(macOS)

import AppKit

extension View {
    
    public func tappableOnInvisibleAreas() -> some View {
        self.overlay {
            Image(nsImage: NSImage())
                .resizable()
                .scaledToFill()
        }
    }
}

#else

import UIKit

extension View {
    
    public func tappableOnInvisibleAreas() -> some View {
        self.overlay {
            Image(uiImage: UIImage())
                .resizable()
                .scaledToFill()
        }
    }
}

#endif
