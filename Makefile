install-lint:
	brew remove swiftlint --force || true
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6d2b793c15e3aef701a6d256035114ff79bca7f1/Formula/swiftlint.rb

install-carthage:
	brew remove carthage --force || true
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/afa125e7aea986ec202b874fac6dee3a6b6a5570/Formula/carthage.rb

install-%:
	true

test-swiftpm:
	swift test

test-carthage:
	carthage build --no-skip-current --configuration Release --verbose
	ls Carthage/Build/Mac/BitArray.framework
	ls Carthage/Build/iOS/BitArray.framework
	ls Carthage/Build/tvOS/BitArray.framework
	ls Carthage/Build/watchOS/BitArray.framework

test-iOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	-destination "name=iPhone 7,OS=10.1" \
	clean test

test-macOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	clean test

test-tvOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	-destination "name=Apple TV 4K" \
	clean test

test-lint:
	swiftlint lint --strict 2>/dev/null
