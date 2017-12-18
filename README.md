# BitArray

A space-efficient bit array with `RandomAccessCollection` conformance in Swift.

## Usage

Specify number of bits when creating an array:

```swift
var a = Array(3) // create an array of length 3
a[0] // false
a[1] = true
a[1] // true
let b = Array(a) // `b` has the same content as `a`.
```

Standard library protocols are honored:

```swift
let c: BitArray = [true, false, true]
let d = c.map { !$0 } // [false, true, false]
print(d) // "[false, true, false]"
c == d // false
```

See source code for more information.

## Installation

### Swift Package Manager

```swift
.package(url: "git@github.com:dduan/BitArray.git", .branch("master")),

```

(and `"BitArray"` to the target's dependencies.)

### CocoaPods

```ruby
use_frameworks!

pod "BitArray"
```

### Carthage

```
github "dduan/BitArray"
```

### Xcode

Include `BitArray.xcodeproj` in your workspace the old-fashioned way.

### Embedding

Include `Sources/BitArray/BitArray.swift` in your project.

## LICENSE

[MIT][https://github.com/dduan/BitArray/blob/master/LICENSE.md].
