import SwiftUI

public extension String {
    func localized(or fallback: String, in bundle: Bundle = .main) -> String {
        let value = localized(in: bundle)
        return self != value ? value : fallback
    }
    
    func localized(in bundle: Bundle = .main) -> String {
        NSLocalizedString(self, bundle: bundle, comment: self)
    }
}
