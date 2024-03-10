import Foundation

#if os(macOS)
public func runCommand(_ cmd: String, args: [String] = []) {
    let process = Process()
    process.launchPath = cmd
    process.arguments = args
    process.launch()
}
#endif
