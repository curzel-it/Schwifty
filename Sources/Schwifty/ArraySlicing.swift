import Foundation

public extension Array {
    var second: Element? {
        count >= 2 ? self[1] : nil
    }
    
    var secondLast: Element? {
        count >= 2 ? self[count-2] : nil
    }
}

public extension Array {
    func first(_ n: Int) -> ArraySlice<Element> {
        guard n > 0 else { return [] }
        let endIndex = n < count ? n : 0
        return self[0..<endIndex]
    }
    
    func last(_ n: Int) -> ArraySlice<Element> {
        guard n > 0 else { return [] }
        let startIndex = n < count ? count-n : 0
        return self[startIndex..<count]
    }
    
    func byRemovingFirst() -> [Element] {
        guard !isEmpty else { return [] }
        return Array(self[1..<count])
    }
    
    func byRemovingLast() -> [Element] {
        guard !isEmpty else { return [] }
        return Array(self[0..<count-1])
    }
    
    func by(adding element: Element) -> Self {
        self + [element]
    }
    
    func by(addingContentsOf elements: [Element]) -> Self {
        self + elements
    }
}

public extension Array where Element: Equatable {
    func by(removing element: Element) -> Self {
        filter { $0 != element }
    }
}
