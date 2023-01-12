import XCTest

@testable import Schwifty

class LocalizationTests: XCTestCase {
    func testNonLocalizedStringsFallbackOnKeyByDefault() {
        XCTAssertEqual("nonLocalizedKey".localized(), "nonLocalizedKey")
    }
    
    func testNonLocalizedStringsMakeUseOfProvidedFallback() {
        XCTAssertEqual("helloWorld".localized(or: "Bruh"), "Bruh")
    }
}
