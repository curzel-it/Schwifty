import Foundation

public extension Sequence {
    func chunks(ofSize size: Int) -> [[Element]] {
        Array(self).chunks(ofSize: size)
    }
}

public extension Array {
    func chunks(ofSize size: Int) -> [[Element]] {
        guard !isEmpty else { return [] }
        guard size <= count else { return [self] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public extension Sequence {
    func split(count parts: Int) -> [[Element]] {
        Array(self).split(count: parts)
    }
}

public extension Array {
    func split(count parts: Int) -> [[Element]] {
        stride(from: 0, to: count, by: parts).map {
            Array(self[$0 ..< Swift.min($0 + parts, count)])
        }
    }
}
