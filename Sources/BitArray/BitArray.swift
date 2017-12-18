public struct BitArray {
    private var byteStore: [UInt8]

    /// Number of bits represented in this array.
    public let count: Int

    /// Create an array filled with repeating 8-bit pattern.
    ///
    /// - parameter bitCount: number of bits in this array.
    /// - parameter pattern:  8-bit pattern used repeatedly to initialize content of the array.
    public init(_ bitCount: Int, byteFillPattern pattern: UInt8 = 0) {
        self.count = bitCount
        var (byteCount, bitRemainder) = bitCount.quotientAndRemainder(dividingBy: 8)
        byteCount += bitRemainder > 0 ? 1 : 0
        self.byteStore = [UInt8](repeating: pattern, count: byteCount)
    }

    /// Create an array with identical content from another.
    ///
    /// - parameter other: array to copy content from.
    public init(_ other: BitArray) {
        self.count = other.count
        self.byteStore = other.byteStore
    }

    /// Create an array with content specified 8-bits at a time.
    ///
    /// - parameter bitCount: number of bits in this array.
    /// - paramater bytes:    content of the array, 8 bits at a time.
    public init(_ bitCount: Int, contentByBytes bytes: [UInt8]) {
        self.count = bitCount
        self.byteStore = bytes
    }

    /// Create an array from specified boolean values.
    ///
    /// - parameter bools: a collection of values in this array.
    public init<T>(_ bools: T) where T: Collection, T.Element == Bool, T.IndexDistance == Int {
        self.init(bools.count)
        for (index, value) in zip(0..., bools) {
            self[index] = value
        }
    }

    /// Access array content by index. Both getting and setting access is O(1).
    public subscript(index: Int) -> Bool {
        get {
            let (byteCount, bitPosition) = index.quotientAndRemainder(dividingBy: 8)
            return self.byteStore[byteCount] & self.mask(for: bitPosition) > 0
        }

        set(newValue) {
            let (byteCount, bitPosition) = index.quotientAndRemainder(dividingBy: 8)
            if newValue {
                self.byteStore[byteCount] |= self.mask(for: bitPosition)
            } else {
                self.byteStore[byteCount] &= ~self.mask(for: bitPosition)
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

extension BitArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Bool...) {
        self.init(elements)
    }
}

extension BitArray: CustomStringConvertible, CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.description
    }

    public var description: String {
        return Array(self).description
    }
}

extension BitArray: Equatable {
    public static func == (lhs: BitArray, rhs: BitArray) -> Bool {
        if lhs.count != rhs.count { return false }
        let lastByteLength = lhs.count % 8
        let mask = self.truncatingMask(for: lastByteLength)
        guard let lhsLastByte = lhs.byteStore.last, let rhsLastByte = rhs.byteStore.last else {
            return true
        }

        if lhsLastByte & mask != rhsLastByte & mask { return false }
        var index = 0
        while index < lhs.byteStore.count - 2 {
            if lhs.byteStore[index] != rhs.byteStore[index] {
                return false
            }
            index += 1
        }

        return true
    }

    @inline(__always)
    private static func truncatingMask(for index: Int) -> UInt8 {
        switch index {
        case 0: return 0b00000000
        case 1: return 0b00000001
        case 2: return 0b00000011
        case 3: return 0b00000111
        case 4: return 0b00001111
        case 5: return 0b00011111
        case 6: return 0b00111111
        case 7: return 0b01111111
        default:
            fatalError("expected 0-7, got \(index)")
        }
    }
}
