# CPP Template
[![CI](https://github.com/davidpl064/cpp-template/actions/workflows/ci.yml/badge.svg)](https://github.com/davidpl064/cpp-template/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/davidpl064/cpp-template/graph/badge.svg?token=IKwtsMUmpk)](https://codecov.io/gh/davidpl064/cpp-template)

This repository aims to serve as a C++ project template, providing all necessary framework (management tool, Github workflows, structure), simplifying creation and configuration of new repositories.

## Project management tool
Selected project management tool is `Conan`, a very popular and standardized Python tool that satisfies almost every project
related need:
- Project metadata.
- Handle dependencies and also required build tools, with versioning.
- Task runner: build, test, etc.
- Package compiled code.

Configuration of this tool is defined in `conanfile.py` file, for further description of this tool and its main characteristics check its [Official Page](https://conan.io/).
The main CLI commands using `conan` are going to be detailed below:
```
# Generate injection environment and build tool files:
conan install . --output-folder=build --build=missing

# Build code
conan build . --build=missing -s build_type=$(CMAKE_BUILD_TYPE)

# Lock dependencies with version and revision
conan lock create .
```

---

# CppLibrary
Short intro to the project (objective, scope, etc).

## Installation
It is needed to install the corresponding project management tool alongside some additional tools prior to start working in the project. The recommended procedure to setup
all the tooling is as follows:
1. Install uv
    - [uv official website](https://docs.astral.sh/uv/getting-started/installation/):
        ```
        curl -LsSf https://astral.sh/uv/install.sh | sh
        ```
2. Install OS dependencies:
    ```
    sudo apt update
    sudo apt install git cmake make lcov clang-tidy clang-format gnupg
    ```
3. Use provided `pyproject.toml` to install necessary Python dependencies and main project management tool (`Conan`):
    ```
    # This will install required Python version alongside all needed modules (using `uv`):
    make install-python-tooling
    ```

## Makefile
To simplify all the operations needed to manage a project, and provide a natural and tool-agnostic interface, `make` commands are used. This way, whichever management tool is used (`uv` or other), the CLI commands would remain the same:
```
# Install Python dependencies
make install-python-tooling

# Build
make build

# Build with testing
make build-cov

# Format source code and auxiliary files
make format

# Linting
make lint

# Test
make test
make test-cov ## with coverage report

# Build and Package compiled code
make package

# Clean build directory
make clean

# Help
make help
```

## Conventional Commits
It is encouraged to follow some conventions when defining commit messages, so it is easier and quicker for everyone to understand the purpose/scope of some changes, and also helps automating workflow processes. The documentation of current convention can be checked in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

## Codecov
Settings are set in the file `codecov.yml`. Check official docs in [Codecov](https://docs.codecov.com/docs/quick-start).
To validate `codecov.yml` file, execute next command:
```
curl -X POST --data-binary @codecov.yml https://codecov.io/validate
```

## Doxygen
This tool allows for live documentation of the code being implemented, so every modification is automatically updated in the docs.
The tool reads specially formatted comments on classes, functions, etc, and parses them into the documentation.
The command to generate the documentation is (settings are stored in `Doxyfile` file):
```
doxygen Doxyfile
```
