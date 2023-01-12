import Foundation

public extension Array where Element: Equatable {
    func contains(anyOf values: any Collection<Element>) -> Bool {
        values.first { contains($0) } != nil
    }

    func contains(allOf values: any Collection<Element>) -> Bool {
        values.first { !contains($0) } == nil
    }

    mutating func remove(_ element: Element) {
        removeAll { $0 == element }
    }
}
