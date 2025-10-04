# Makefile for FindMeAppCTLTest
# Convenient commands for building and testing

.PHONY: help build test test-ui clean verify install-xcodegen generate-project

# Default simulator
SIMULATOR ?= iPhone 15
SCHEME = FindMeAppCTLTest
PROJECT = FindMeAppCTLTest.xcodeproj

# Real device
DEVICE_ID = 00008110-001E64343483801E
DEVICE_NAME = Chi Thu – iPhone (180)

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

verify: ## Verify project setup
	@./scripts/verify_setup.sh

build: ## Build the project
	@echo "🔨 Building project..."
	@xcodebuild build \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)' \
		| xcpretty || true

test: ## Run all tests
	@echo "🧪 Running all tests..."
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)' \
		| xcpretty || true

test-ui: ## Run UI tests only
	@echo "🧪 Running UI tests..."
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)' \
		-only-testing:FindMeAppCTLTestUITests \
		| xcpretty || true

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)' \
		-only-testing:FindMeAppCTLTestTests \
		| xcpretty || true

clean: ## Clean build artifacts
	@echo "🧹 Cleaning build folder..."
	@xcodebuild clean \
		-project $(PROJECT) \
		-scheme $(SCHEME)
	@rm -rf ~/Library/Developer/Xcode/DerivedData/FindMeAppCTLTest-*

install-xcodegen: ## Install XcodeGen via Homebrew
	@echo "📦 Installing XcodeGen..."
	@brew install xcodegen

generate-project: ## Generate Xcode project from project.yml (requires XcodeGen)
	@echo "🔄 Generating Xcode project from project.yml..."
	@xcodegen generate
	@echo "✅ Project regenerated"

list-simulators: ## List available iOS simulators
	@xcrun simctl list devices iOS available

open: ## Open project in Xcode
	@open $(PROJECT)

# Advanced commands

test-verbose: ## Run tests with verbose output
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)' \
		-verbose

build-for-testing: ## Build for testing without running tests
	@xcodebuild build-for-testing \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)'

test-without-building: ## Run tests without building
	@xcodebuild test-without-building \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS Simulator,name=$(SIMULATOR)'

# Device testing commands

test-device: ## Run all UI tests on real device
	@echo "📱 Running UI tests on device: $(DEVICE_NAME)..."
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS,id=$(DEVICE_ID)' \
		-only-testing:FindMeAppCTLTestUITests \
		| xcpretty || true

test-device-tabs: ## Run tab navigation test on real device
	@echo "📱 Running tab navigation test on device..."
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS,id=$(DEVICE_ID)' \
		-only-testing:FindMeAppCTLTestUITests/testNavigateThroughAllTabs \
		| xcpretty || true

build-device: ## Build for real device
	@echo "🔨 Building for device: $(DEVICE_NAME)..."
	@xcodebuild build \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS,id=$(DEVICE_ID)' \
		| xcpretty || true

list-devices: ## List all connected devices
	@echo "📱 Available devices:"
	@xcrun xctrace list devices | grep -E "^[A-Za-z].*\([0-9]"

# Xcode version management

xcode-version: ## Show current Xcode version
	@echo "Current Xcode path:"
	@xcode-select -p
	@echo ""
	@echo "Xcode version:"
	@xcodebuild -version

switch-xcode-beta: ## Switch to Xcode Beta
	@./scripts/switch_to_xcode_beta.sh

switch-xcode-stable: ## Switch to Xcode Stable
	@./scripts/switch_to_xcode_stable.sh

# UI Inspection

inspect-ui: ## Run UI inspection test and save output
	@echo "🔍 Running UI inspection test..."
	@mkdir -p inspections
	@xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=iOS,id=$(DEVICE_ID)' \
		-only-testing:FindMeAppCTLTestUITests/FindMyUIInspectionTests \
		2>&1 | tee inspections/ui_inspection_$$(date +%Y%m%d_%H%M%S).log
	@echo "✅ Inspection complete! Check inspections/ folder"
