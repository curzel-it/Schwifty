import XCTest

@testable import Schwifty

class ArraySlicingTests: XCTestCase {
    func testCanChunkArray() {
        XCTAssertEqual([Int]().chunks(ofSize: 3), [])
        XCTAssertEqual([1,2,3].chunks(ofSize: 3), [[1,2,3]])
        XCTAssertEqual([1,2,3].chunks(ofSize: 1), [[1],[2],[3]])
        XCTAssertEqual([1,2,3].chunks(ofSize: 2), [[1,2],[3]])
        XCTAssertEqual([1,2,3,4].chunks(ofSize: 3), [[1,2,3],[4]])
    }
    
    func testCanSplitArray() {
        XCTAssertEqual([1,2,3].split(numberOfParts: 0), [])
        XCTAssertEqual([1,2,3].split(numberOfParts: 2), [[1,2], [3]])
        XCTAssertEqual([1,2,3,4].split(numberOfParts: 2), [[1,2], [3,4]])
        XCTAssertEqual([1,2,3,4].split(numberOfParts: 4), [[1],[2],[3],[4]])
    }
}
