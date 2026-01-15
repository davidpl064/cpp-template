import os

from conan import ConanFile
from conan.errors import ConanInvalidConfiguration
from conan.tools.cmake import CMake, CMakeDeps, cmake_layout, CMakeToolchain
from conan.tools.scm import Version
import subprocess

from pathlib import Path


class CppTemplateRecipe(ConanFile):
    # Project metadata
    name = "cpp-template"
    languages = "C++"

    license = "MIT"
    author = "David Perez Lamarca davi.perlam@gmail.com"
    url = "https://github.com/davidpl064/cpp-template"
    description = "A modern C++ project template with CMake, Clang tooling, and testing"
    topics = ("cpp", "template", "cmake", "conan", "clang") # tags

    # Binary configuration
    settings = "os", "arch", "compiler", "build_type"
    options = {"shared": [True, False], "with_cov": [True, False]}
    default_options = {"shared": False, "with_cov": False}

    # Sources are located in the same place as this recipe, copy them to the recipe
    exports_sources = (
        "cpp_template/*",
        "tests/*",
        "cmake/*",
        "CMakeLists.txt",
        "version.txt",
        "*.md",
        ".clang-format",
        ".clang-tidy",
        "docs/*",
    )

    def set_version(self):
        try:
            with open("version.txt") as f:
                self.version = f.read().strip()
        except FileNotFoundError:
            self.version = "0.0.0"

    def requirements(self):
        self.requires(
            "zlib/[~1.3]",
        )

    def build_requirements(self):
        self.tool_requires("cmake/3.27.9")

        self.test_requires("gtest/[~1.17]")

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        
        tc = CMakeToolchain(self)
        # Inject ENABLE_COVERAGE from Conan option
        if self.options.with_cov:
            tc.variables["ENABLE_COVERAGE"] = True
        tc.generate()

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

        if not self.conf.get("tools.build:skip_test", default=False):
            test_folder = Path("tests").resolve()
            if self.settings.os == "Windows":
                test_folder = test_folder/str(self.settings.build_type)

            # self.run(test_folder/"unit_tests")
            # self.run(test_folder/"integration_tests")
            self.run("ctest --output-on-failure", cwd=self.build_folder)

    def validate(self):
        if self.settings.os == "Macos" and self.settings.arch == "armv8":
            raise ConanInvalidConfiguration("ARM v8 not supported in Macos")

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        # Provide the library name for consumers
        self.cpp_info.libs = ["cpp_template"]
        self.cpp_info.set_property("cmake_target_name", "cpp_template::cpp_template")