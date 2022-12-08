import SwiftUI

public extension Image {
    func pixelArt() -> some View {
        interpolation(.none)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
