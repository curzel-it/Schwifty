import Foundation

public extension Optional {
    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw OptionalError.unwrappingOptionalValue
        }
    }
}

public enum OptionalError: Error {
    case unwrappingOptionalValue
}
