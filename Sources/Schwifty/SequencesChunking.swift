import Foundation

public extension Sequence {
    func chunked(into size: Int) -> [[Element]] {
        Array(self).chunked(into: size)
    }
}

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard !isEmpty else { return [] }
        guard size <= count else { return [self] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
