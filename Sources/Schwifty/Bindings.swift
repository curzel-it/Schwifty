import Combine
import SwiftUI

public extension Binding {
    static func of<T>(
        getter: @escaping () -> T,
        setter: @escaping (T) -> Void = { _ in }
    ) -> Binding<T> {
        Binding<T>(get: getter, set: setter)
    }
}
