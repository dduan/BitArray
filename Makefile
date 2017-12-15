install-carthage:
	brew remove carthage --force
	brew install carthage

install-swiftlint:
	brew remove swiftlint --force
	brew install swiftlint

install-%:
	true

test-lint:
	swiftlint lint --strict 2>/dev/null

test-iOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	-destination "name=iPhone 7" \
	clean test

test-macOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	clean test

test-tvOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
	-destination "name=Apple TV" \
	clean test

test-carthage:
	carthage build --no-skip-current --configuration Release --verbose
	ls Carthage/Build/Mac/BitArray.framework
	ls Carthage/Build/iOS/BitArray.framework
	ls Carthage/Build/tvOS/BitArray.framework
	ls Carthage/Build/watchOS/BitArray.framework

test-swiftpm:
	swift test
