import Foundation

public extension FileManager {
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    func fileExists(at url: URL) -> Bool {
        fileExists(atPath: url.path())
    }
    
    func files(in url: URL, withExtension fileExtension: String) -> [URL] {
        let allFiles = try? contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        
        return (allFiles ?? [])
            .filter { $0.pathExtension.lowercased() == fileExtension }
    }
    
    func filesRecursively(from url: URL) -> [URL] {
        let enumerator = enumerator(at: url, includingPropertiesForKeys: nil)
        var files: [URL] = []
        
        while let element = enumerator?.nextObject() as? URL {
            files.append(element)
        }
        return files
    }
    
    func creationDate(for url: URL) -> Date? {
        let attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
        return attributes?[.creationDate] as? Date
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    func createIntermediateDirectories(toDirectory url: URL) throws {
        guard !fileExists(atPath: url.path()) else { return }
        try createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    func createIntermediateDirectories(toFile url: URL) throws {
        try createIntermediateDirectories(toDirectory: url.deletingLastPathComponent())
    }
}

public extension URL {
    func replacingFileExtension(with newExtension: String) -> URL {
        guard !pathExtension.isEmpty else { return self }
        let urlWithoutExtension = deletingPathExtension()
        return urlWithoutExtension.appendingPathExtension(newExtension)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    func isExistingFolder() -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path(), isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
}
