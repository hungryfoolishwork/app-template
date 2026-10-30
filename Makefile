XCODEPROJ := app/Project.xcodeproj
TARGET := Project
TARGET_IOS := Project-iOS

.PHONY: build build-ios test rename

build:
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET) -destination 'platform=macOS' build

build-ios:
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET_IOS) -destination 'generic/platform=iOS Simulator' build

test:
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET) -destination 'platform=macOS' test

# Release builds for App Store Connect. Archive, then upload the archive straight to App Store
# Connect with the account signed in to Xcode. The build number is APP_VERSION in
# app/Config/Shared.xcconfig; bump it before archiving a build to upload.
ARCHIVES := .build/archives
EXPORT_OPTIONS := app/Config/ExportOptions.plist

.PHONY: archive archive-ios upload upload-ios release release-ios

# Archive, then upload, stopping if the archive fails. Steps rather than prerequisites, so
# `make -j` can't run them at once.
release:
	$(MAKE) archive
	$(MAKE) upload

release-ios:
	$(MAKE) archive-ios
	$(MAKE) upload-ios

archive:
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET) -configuration Release -destination 'generic/platform=macOS' \
		-archivePath $(ARCHIVES)/$(TARGET).xcarchive -allowProvisioningUpdates archive

archive-ios:
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET_IOS) -configuration Release -destination 'generic/platform=iOS' \
		-archivePath $(ARCHIVES)/$(TARGET_IOS).xcarchive -allowProvisioningUpdates archive

upload:
	xcodebuild -exportArchive -archivePath $(ARCHIVES)/$(TARGET).xcarchive -exportOptionsPlist $(EXPORT_OPTIONS) \
		-exportPath $(ARCHIVES)/upload/macOS -allowProvisioningUpdates

upload-ios:
	xcodebuild -exportArchive -archivePath $(ARCHIVES)/$(TARGET_IOS).xcarchive -exportOptionsPlist $(EXPORT_OPTIONS) \
		-exportPath $(ARCHIVES)/upload/iOS -allowProvisioningUpdates

# Build, install, and launch on a paired device over USB or Wi-Fi. Picks the first physical iPhone
# devicectl knows; pass DEVICE=<udid> to choose another, CONFIG=Debug for a debug build. Installing
# over a TestFlight build replaces it. DEVICE looks itself up once, on first use.
IOS_BUILD := .build/ios
CONFIG ?= Release
BUNDLE_ID := $(shell sed -n 's/^APP_BUNDLE_IDENTIFIER = //p' app/Config/Shared.xcconfig)
DEVICE ?= $(eval DEVICE := $(shell xcrun devicectl list devices --quiet --json-output /dev/stdout 2>/dev/null | \
	jq -r '[.result.devices[] | select(.hardwareProperties.reality == "physical" and .hardwareProperties.deviceType == "iPhone")][0].hardwareProperties.udid // empty'))$(DEVICE)

.PHONY: install-ios

install-ios:
	@test -n "$(DEVICE)" || { echo "No paired iPhone found; pass DEVICE=<udid>." >&2; exit 1; }
	xcodebuild -project $(XCODEPROJ) -scheme $(TARGET_IOS) -configuration $(CONFIG) -destination 'id=$(DEVICE)' \
		-derivedDataPath $(IOS_BUILD) -allowProvisioningUpdates build
	xcrun devicectl device install app --device $(DEVICE) $(IOS_BUILD)/Build/Products/$(CONFIG)-iphoneos/$(TARGET).app
	xcrun devicectl device process launch --device $(DEVICE) $(BUNDLE_ID)

# REMOVE!!!
# After renaming the project template remove this command
rename:
ifndef NAME
	$(error usage: make rename NAME=NewName [BUNDLE=com.example.newname])
endif
	scripts/rename.sh $(NAME) $(BUNDLE)
