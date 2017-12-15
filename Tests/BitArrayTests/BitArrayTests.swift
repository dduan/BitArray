import XCTest
import BitArray

class BitArrayTests: XCTestCase {
    func testBasicMutation() {
        var a = BitArray(5)
        a[3] = true
        a[4] = true
        XCTAssertEqual(Array(a), [false, false, false, true, true])
    }


    static var allTests = [
        ("testBasicMutation", testBasicMutation),
    ]
}
