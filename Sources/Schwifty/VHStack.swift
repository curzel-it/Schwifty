import SwiftUI

public struct VHStack<Content: View>: View {
    let content: () -> Content
    let isHorizontal: Bool
    let spacing: CGFloat?

    public init(
        _ axis: Axis.Set,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        isHorizontal = axis.contains(.horizontal)
        self.spacing = spacing
    }

    public var body: some View {
        ZStack {
            if isHorizontal {
                HStack(spacing: spacing) { content() }
            } else {
                VStack(spacing: spacing) { content() }
            }
        }
    }
}
