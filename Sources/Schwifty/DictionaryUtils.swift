import Foundation

public extension Dictionary {
    func merging(with other: [Key: Value]) -> [Key: Value] {
        merging(other) { _, newValue in newValue }
    }
}

public extension Dictionary {
    func jsonString() -> String {
        guard let data = try? JSONSerialization.data(
            withJSONObject: self, options: [.prettyPrinted]
        ) else { return "n/a" }
        return String(data: data, encoding: .utf8) ?? "n/a"
    }
}

public extension Dictionary {
    func pairs() -> [(Key, Value)] {
        reduce([(Key, Value)]()) { result, element in
            var updatedResult = result
            updatedResult.append((element.key, element.value))
            return updatedResult
        }
    }
}
