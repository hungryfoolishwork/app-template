XCODEPROJ := app/Project.xcodeproj

.PHONY: build build-ios test rename

build:
	xcodebuild -project $(XCODEPROJ) -scheme Project -destination 'platform=macOS' build

build-ios:
	xcodebuild -project $(XCODEPROJ) -scheme Project-iOS -destination 'generic/platform=iOS Simulator' build

test:
	xcodebuild -project $(XCODEPROJ) -scheme Project -destination 'platform=macOS' test

rename:
ifndef NAME
	$(error usage: make rename NAME=NewName [BUNDLE=com.example.newname])
endif
	scripts/rename.sh $(NAME) $(BUNDLE)
