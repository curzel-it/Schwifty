import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

public extension View {
    func when(_ condition: Bool, @ViewBuilder modifier: @escaping (Self) -> some View) -> AnyView {
        if condition {
            modifier(self).eraseToAnyView()
        } else {
            self.eraseToAnyView()
        }
    }
}
