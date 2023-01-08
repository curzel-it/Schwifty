import Foundation

public extension Array where Element: Equatable & Hashable {
    func removeDuplicates(keepOrder: Bool) -> [Element] {
        if !keepOrder {
            return Array(Set(self))
        } else {
            var buffer: [Element] = []
            var added = Set<Element>()
            buffer.reserveCapacity(count)
            forEach { element in
                if !added.contains(element) {
                    added.insert(element)
                    buffer.append(element)
                }
            }
            return buffer
        }
    }
}
