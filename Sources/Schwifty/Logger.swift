import Foundation

public class Logger {
    public static var isEnabled: Bool = true
    
    public static func log(_ component: String, _ items: String?...) {
        log(logLevel: .verbose, component: component, items: items)
    }
    
    public static func debug(_ component: String, _ items: String?...) {
        log(logLevel: .debug, component: component, items: items)
    }
    
    public static func error(_ component: String, _ items: String?...) {
        log(logLevel: .error, component: component, items: items)
    }
    
    private static func log(logLevel: LogLevel, component: String, items: [String?]) {
        guard isEnabled else { return }
        let timestamp = Date().string("HH:mm:ss.SSS")
        let body = logString(for: items)
        print("\(logLevel.rawValue): \(timestamp) [\(component)] \(body)")
    }
    
    private static func logString(for items: [String?]) -> String {
        items.map { $0 ?? "nil" }.joined(separator: " ")
    }
}

public enum LogLevel: String {
    case verbose = "V"
    case debug = "D"
    case error = "E"
}
