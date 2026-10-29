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

# REMOVE!
# After renaming the project template remove this command
rename:
ifndef NAME
	$(error usage: make rename NAME=NewName [BUNDLE=com.example.newname])
endif
	scripts/rename.sh $(NAME) $(BUNDLE)
