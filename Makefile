install-lint:
	brew remove swiftlint --force || true
	brew install swiftlint

install-carthage:
	brew remove carthage --force || true
	brew install carthage

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
	-destination "name=iPhone 7" \
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
