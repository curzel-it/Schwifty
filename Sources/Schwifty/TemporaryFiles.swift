import Foundation

public class TemporaryFiles {
    private let fileManager = FileManager.default
    private let tempFolder: URL
    
    public init(name: String) throws {
        tempFolder = fileManager
            .temporaryDirectory
            .appendingPathComponent(name, conformingTo: .folder)
        try createTempFolder()
    }
    
    public func next(withExtension: String? = nil) -> URL {
        let filename = [UUID().uuidString, withExtension]
            .compactMap { $0 }
            .joined(separator: ".")
        return tempFolder.appendingPathComponent(filename)
    }
        
    public func clearAll() throws {
        try fileManager.removeItem(at: tempFolder)
        try createTempFolder()
    }
    
    private func createTempFolder() throws {
        try fileManager.createDirectory(at: tempFolder, withIntermediateDirectories: true)
    }
}

public extension URL {
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    var isTemporary: Bool {
        path().contains(FileManager.default.temporaryDirectory.path())
    }
}
