#if os(macOS)
import Foundation

public extension Process {
    static func execute(_ command: String, arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: command)
        process.arguments = arguments
        try process.run()
        process.waitUntilExit()
    }
}
#endif
