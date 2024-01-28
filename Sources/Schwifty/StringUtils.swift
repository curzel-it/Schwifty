import Foundation
import CryptoKit

public extension String {
    init?(contentsOfResource name: String, withExtension fileExtension: String, subdirectory: String? = nil) {
        let url = Bundle.main.url(forResource: name, withExtension: fileExtension, subdirectory: subdirectory)
        guard let url else { return nil }
        do {
            try self.init(contentsOf: url)
        } catch {
            return nil
        }
    }    
    
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func md5() -> String {
        let data = Data(self.utf8)
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func splitCamelCase() -> [String] {
        var words = [String]()
        var currentWord = ""

        for char in self {
            if char.isUppercase {
                if !currentWord.isEmpty {
                    words.append(currentWord)
                }
                currentWord = String(char).lowercased()
            } else {
                currentWord += String(char)
            }
        }

        if !currentWord.isEmpty {
            words.append(currentWord)
        }
        return words
    }
}

public extension Optional<String> {
    var isNilOrEmpty: Bool {
        switch self {
        case .none: true
        case .some(let wrapped): wrapped.isEmpty
        }
    }
    
    var isNilOrBlank: Bool {
        switch self {
        case .none: true
        case .some(let wrapped): wrapped.isBlank
        }
    }
}

public extension String {
    func urlSafe() -> String {
        String(
            filter {
                guard let char = $0.unicodeScalars.first else { return false }
                return CharacterSet.alphanumerics.contains(char)
            }
        )
    }
}
