import Foundation

public extension FileManager {
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
    
    func temporaryFileUrl(withExtension: String? = nil) -> URL {
        let filename = [UUID().uuidString, withExtension]
            .compactMap { $0 }
            .joined(separator: ".")
        return temporaryDirectory.appendingPathComponent(filename)
    }
}

public extension URL {
    func replacingFileExtension(with newExtension: String) -> URL {
        guard !pathExtension.isEmpty else { return self }
        let urlWithoutExtension = deletingPathExtension()
        return urlWithoutExtension.appendingPathExtension(newExtension)
    }
}
