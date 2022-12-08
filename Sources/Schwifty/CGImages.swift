import SwiftUI

public extension CGImage {
    static func from(contentsOfPng url: URL) -> CGImage? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let dataProvider = CGDataProvider(data: data as CFData) else { return nil }

        return CGImage(
            pngDataProviderSource: dataProvider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
    }
}
