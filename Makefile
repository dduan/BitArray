export SWIFTENV_ROOT := $(HOME)/.swiftenv
export PATH := $(SWIFTENV_ROOT)/bin:$(SWIFTENV_ROOT)/shims:$(PATH)

install-lint:
	brew remove swiftlint --force || true
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6d2b793c15e3aef701a6d256035114ff79bca7f1/Formula/swiftlint.rb

install-carthage:
	brew remove carthage --force || true
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/afa125e7aea986ec202b874fac6dee3a6b6a5570/Formula/carthage.rb

install-swiftpm-linux:
	eval "$(curl -sL https://gist.githubusercontent.com/kylef/5c0475ff02b7c7671d2a/raw/9f442512a46d7a2af7b850d65a7e9bd31edfb09b/swiftenv-install.sh)"

install-%:
	true

test-swiftpm-macOS:
	swift test

test-swiftpm-linux:
	git clone --depth 1 https://github.com/kylef/swiftenv.git ~/.swiftenv
	swiftenv install -s

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
