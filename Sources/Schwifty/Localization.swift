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

public extension Int {
    func localizedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
