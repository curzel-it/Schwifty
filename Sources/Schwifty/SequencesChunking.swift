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
    func split(numberOfParts parts: Int) -> [[Element]] {
        Array(self).split(numberOfParts: parts)
    }
}

public extension Array {
    func split(numberOfParts parts: Int) -> [[Element]] {
        guard parts > 0 else { return [] }
        let chunkSize = self.count / parts
        let extraElements = self.count % parts
        var result: [[Element]] = []
        var startIndex = 0
        
        for chunkIndex in 0..<parts {
            var endIndex = startIndex + chunkSize
            if chunkIndex < extraElements {
                endIndex += 1
            }
            if endIndex > self.count { endIndex = self.count }
            let chunk = Array(self[startIndex..<endIndex])
            result.append(chunk)
            startIndex = endIndex
        }
        
        return result
    }
}
