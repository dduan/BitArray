install-carthage:
	brew remove carthage --force || true
	brew install carthage

install-%:
	true

test-iOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
		-destination "name=iPhone 7,OS=10.3.1" \
		test

test-macOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
		test

test-tvOS:
	xcodebuild -project BitArray.xcodeproj -scheme BitArray -configuration Release \
		-destination "name=Apple TV" \
		test

test-carthage:
	carthage build --no-skip-current --configuration Release --verbose
	ls Carthage/Build/Mac/BitArray.framework
	ls Carthage/Build/iOS/BitArray.framework
	ls Carthage/Build/tvOS/BitArray.framework
	ls Carthage/Build/watchOS/BitArray.framework

test-swiftpm:
	swift test
