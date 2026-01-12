import os

from conan import ConanFile
from conan.errors import ConanInvalidConfiguration
from conan.tools.cmake import CMake, CMakeDeps, cmake_layout


class CppTemplateRecipe(ConanFile):
    name = "cpp_template"
    version = "0.1.0"
    license = "MIT"
    author = "David Perez Lamarca <davi.perlam@gmail.com>"
    url = "https://github.com/yourusername/cpp_template"
    description = "A modern C++ project template with CMake, Clang tooling, and testing"
    topics = ("cpp", "template", "cmake", "conan", "clang")
    settings = "os", "arch", "compiler", "build_type"
    generators = "CMakeDeps", "CMakeToolchain"
    exports_sources = (
        "cpp_template/*",
        "tests/*",
        "CMakeLists.txt",
        "*.md",
        ".clang-format",
        ".clang-tidy",
        "docs/*",
    )

    options = {"shared": [True, False]}
    default_options = {"shared": False}

    def requirements(self):
        self.requires(
            "gtest/1.14.0",
            "zlib/1.3.1",
        )

    def build_requirements(self):
        self.tool_requires("cmake/3.27.9")

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def validate(self):
        if self.settings.os == "Macos" and self.settings.arch == "armv8":
            raise ConanInvalidConfiguration("ARM v8 not supported in Macos")

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        # Provide the library name for consumers
        self.cpp_info.libs = ["cpp_template"]
        self.cpp_info.libs = ["cpp_template"]
