import XCTest
import BitArray

class BitArrayTests: XCTestCase {
    func testMutation() {
        var a = BitArray(5)
        a[3] = true
        a[4] = true
        XCTAssertEqual(Array(a), [false, false, false, true, true])
    }

    func testCountConsistency() {
        let a = BitArray(17)
        XCTAssertEqual(a.count, 17)
    }

    func testCopying() {
        let a = BitArray(9, contentByBytes: [0b00010001, 0b00000000])
        XCTAssertEqual(a, BitArray(a))
    }

    func testEquatableDoesNotConsiderExtraBits() {
        let a: BitArray = [true, false, true]
        let b = BitArray(3, byteFillPattern: 0b11110101)
        let c = BitArray(3, byteFillPattern: 0b00001101)
        XCTAssertEqual(a, b)
        XCTAssertEqual(c, b)
    }

    func testEquatableConsidersArrayCount() {
        let a = BitArray(3, byteFillPattern: 0b11110101)
        let b = BitArray(4, byteFillPattern: 0b11110101)
        XCTAssertNotEqual(a, b)
    }

    func testFillPattern() {
        let pattern: UInt8 = 0b11110101

        XCTAssertEqual(
            BitArray(16, byteFillPattern: pattern),
            BitArray(16, contentByBytes: [pattern, pattern])
        )
    }

    static var allTests = [
        ("testMutation", testMutation),
    ]
}
