import XCTest

@testable import Schwifty

class RectUtilsTests: XCTestCase {
    func testSmallestEnclosingRectangleForASingleRectIsTheSameRect() {
        let rect = CGRect(x: 10, y: 10, width: 10, height: 10)
        let result = [rect].smallestEnclosingRectangle()
        XCTAssertEqual(result, rect)
    }
}
