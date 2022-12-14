import Foundation

public class Logger {
    public static var isEnabled: Bool = true
    
    public static func log(_ component: String, _ items: String?...) {
        guard isEnabled else { return }
        let timestamp = Date().string("HH:mm:ss.SSS")
        let body = logString(for: items)
        print("\(timestamp) [\(component)] \(body)")
    }
    
    private static func logString(for items: [String?]) -> String {
        items.map { $0 ?? "nil" }.joined(separator: " ")
    }
}
