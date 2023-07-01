import XCTest

@testable import Schwifty

class StringDelimitersTests: XCTestCase {
    func testCanDetectSubstring() {
        XCTAssertEqual(try? "aaa?ciao|bbb".substring(delimitedBy: "?", and: "|"), "ciao")
        XCTAssertEqual(try? "aa?ciao|b?b|".substring(delimitedBy: "?", and: "|"), "ciao")
    }
    
    func testThrowsWhenStartIsNotFound() {
        XCTAssertThrowsError(try "abc".substring(delimitedBy: "d", and: "c")) {
            XCTAssertEqual(
                $0 as? DelimitedSubstringError,
                DelimitedSubstringError.startDelimiterNotFound
            )
        }
    }
    
    func testThrowsWhenEndIsNotFound() {
        XCTAssertThrowsError(try "abc".substring(delimitedBy: "a", and: "d")) {
            XCTAssertEqual(
                $0 as? DelimitedSubstringError,
                DelimitedSubstringError.endDelimiterNotFound
            )
        }
    }
}
