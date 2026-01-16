from pathlib import Path

from conan import ConanFile
from conan.tools.build import can_run
from conan.tools.cmake import CMake, cmake_layout


class DummyTestConan(ConanFile):
    """Dummy recipe to test consuming main project's package,
    as it would be used from a third party tool.
    """

    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"

    def requirements(self):
        """Set dependencies requirements."""
        self.requires(self.tested_reference_str)

    def build_requirements(self):
        """Set requirements for build tools."""
        self.tool_requires("cmake/3.27.9")

    def build(self):
        """Call set compiler to build project."""
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def layout(self):
        """Define layout."""
        cmake_layout(self)

    def test(self):
        """Test consuming project's package."""
        if can_run(self):
            cmd = Path(self.cpp.build.bindir).resolve() / "consumer_pkg"
            self.run(cmd, env="conanrun")
