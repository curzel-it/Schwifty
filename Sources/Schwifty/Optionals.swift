import Foundation

public extension Optional {
    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw OptionalError.unwrappingOptionalValue
        }
    }
    
    func `let`<T>(_ handler: (Wrapped) -> T) -> T? {
        if case .some(let value) = self {
            return handler(value)
        }
        return nil
    }
}

public enum OptionalError: Error {
    case unwrappingOptionalValue
}
