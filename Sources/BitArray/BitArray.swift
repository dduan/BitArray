public struct BitArray {
    private var store: [UInt8]

    public let count: Int

    public init(_ bitCount: Int, fillPattern pattern: UInt8 = 0) {
        self.count = bitCount
        var (byteCount, bitRemainder) = bitCount.quotientAndRemainder(dividingBy: 8)
        byteCount += bitRemainder > 0 ? 1 : 0
        self.store = [UInt8](repeating: pattern, count: byteCount)
    }

    public init(_ other: BitArray) {
        self.count = other.count
        self.store = other.store
    }

    public init(_ bitCount: Int, content: [UInt8]) {
        self.count = bitCount
        self.store = content
    }

    public subscript(index: Int) -> Bool {
        get {
            let (byteCount, bitPosition) = index.quotientAndRemainder(dividingBy: 8)
            return self.store[byteCount] & self.mask(for: bitPosition) > 0
        }

        set(newValue) {
            let (byteCount, bitPosition) = index.quotientAndRemainder(dividingBy: 8)
            if newValue {
                self.store[byteCount] |= self.mask(for: bitPosition)
            } else {
                self.store[byteCount] &= ~self.mask(for: bitPosition)
            }
        }
    }

    @inline(__always)
    private func mask(for index: Int) -> UInt8 {
        switch index {
        case 0: return 0b00000001
        case 1: return 0b00000010
        case 2: return 0b00000100
        case 3: return 0b00001000
        case 4: return 0b00010000
        case 5: return 0b00100000
        case 6: return 0b01000000
        case 7: return 0b10000000
        default:
            fatalError("expected 0-7, got \(index)")
        }
    }
}

extension BitArray: RandomAccessCollection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return self.count }
}
