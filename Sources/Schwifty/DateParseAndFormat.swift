import Foundation

public extension Date {
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func from(_ someString: String?, using format: String) -> Date? {
        guard let string = someString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
}
