import SwiftUI

public extension View {
    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }

    func frame(sizeOf rect: CGRect) -> some View {
        frame(size: rect.size)
    }
}
