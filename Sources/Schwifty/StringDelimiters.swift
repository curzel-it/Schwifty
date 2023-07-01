import Foundation

public extension String {
    func substring(delimitedBy start: String, and end: String) throws -> String {
        let tokens = components(separatedBy: start)
        if tokens.count < 2 {
            throw DelimitedSubstringError.startDelimiterNotFound
        }
        let words = tokens[1].components(separatedBy: end)
        if words.count <= 1 && start != end {
            throw DelimitedSubstringError.endDelimiterNotFound
        }
        return words[0]
    }
}

public enum DelimitedSubstringError: Error {
    case startDelimiterNotFound
    case endDelimiterNotFound
}
