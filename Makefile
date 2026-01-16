.PHONY: help install-python build build-cov build-simple test package test_package run format lint clean

# Project settings
PROJECT_NAME := cpp_template
PACKAGE_NAME := cpp-template
PROJECT_VERSION := $(shell git tag --sort=-v:refname | head -n1 | sed 's/^v//')
CMAKE_BUILD_TYPE ?= Debug
SRC_DIR := ${PROJECT_NAME}/src
INCLUDE_DIR := ${PROJECT_NAME}/include
TESTS_DIR := tests
BUILD_DIR := build

# Tool settings
CONAN := conan

GREEN_COLOR  := \033[0;32m
RESET_COLOR  := \033[0m

install-python:
	uv sync --dev
	uv run pre-commit install
	@echo "Activate env with: $(GREEN_COLOR)source .venv/bin/activate$(RESET_COLOR)"

build:
	$(CONAN) build . --build=missing -s build_type=$(CMAKE_BUILD_TYPE)

build-cov:  ## build with coverage flags
	$(CONAN) build . --build=missing -s build_type=Debug -o "&:with_cov=True"

build-simple:  ## build project
	@echo "=== Installing dependencies with Conan ==="
	$(CONAN) install . --build=missing

	@echo "=== Building project ==="
	cd . $(BUILD_DIR)/$(CMAKE_BUILD_TYPE)/generators/conanbuild.sh && \
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && \
	cmake --build $(BUILD_DIR)

lock:  ## lock dependencies
	$(CONAN) lock create .

test:  ## run tests
	ctest --test-dir $(BUILD_DIR)/$(CMAKE_BUILD_TYPE) --output-on-failure
test-cov:  ## run tests with coverage reports
	ctest -V --test-dir $(BUILD_DIR)/Debug --output-on-failure --output-junit junit-results.xml

run:  ## run main executable
	$(BUILD_DIR)/$(PROJECT_NAME)

format:  ## format source code
	clang-format -style=file -i $$(find $(SRC_DIR) $(INCLUDE_DIR) $(TESTS_DIR) -name '*.cpp' -o -name '*.hpp')

lint:  ## run static analysis
	clang-tidy --config-file=.clang-tidy -p $(BUILD_DIR)/$(CMAKE_BUILD_TYPE) $$(find $(SRC_DIR) $(TESTS_DIR) -name '*.cpp')

package:  ## build and create package
	$(CONAN) create . -s build_type=$(CMAKE_BUILD_TYPE)

# package:  ## install
# 	cmake --install $(BUILD_DIR)

test_package:  ## test to consume project as package
	$(CONAN) test test_package $(PACKAGE_NAME)/$(PROJECT_VERSION)

clean:  ## remove build directory
	rm -rf $(BUILD_DIR)

help:  ## this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
