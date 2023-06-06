import XCTest

@testable import Schwifty

class OptionalTests: XCTestCase {
    func testUnwrapThrowsIfNone() {
        let value: String? = nil
        XCTAssertThrowsError(try value.unwrap())
    }

    func testUnwrapReturnsValueIfNotNone() {
        let value: String? = "something"
        XCTAssertNoThrow(try value.unwrap())
        XCTAssertEqual(try value.unwrap(), "something")
    }
    
    func testUnwrapLetReturnsNilIfNone() {
        let value: Int? = nil
        XCTAssertNil(value.let { $0 + 1 })
    }
    
    func testUnwrapLetEvaluatesIfNone() {
        let value: Int? = 0
        XCTAssertEqual(value.let { $0 + 1 }, 1)
    }
}
