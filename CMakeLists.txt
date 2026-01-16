cmake_minimum_required(VERSION 3.20)
include(cmake/version.cmake)

# ---------------------------------------------------------------------
# Project metadata
# ---------------------------------------------------------------------
project(
    cpp_template
    VERSION ${PROJECT_VERSION}
    DESCRIPTION "Brief description of the C++ project."
    LANGUAGES CXX
)


# ---------------------------------------------------------------------
# Global build settings
# ---------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Export compile_commands.json (clang-tidy, clangd, etc.)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Default build type (only applies to single-config generators)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
endif()

# ---------------------------------------------------------------------
# Options (feature toggles)
# ---------------------------------------------------------------------
option(ENABLE_WARNINGS "Enable compiler warnings" ON)
option(ENABLE_TESTS "Enable unit tests" ON)
option(ENABLE_EXAMPLES "Build examples" ON)

# Coverage option
option(ENABLE_COVERAGE "Enable coverage" OFF)

if(ENABLE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    message(STATUS "Building with coverage flags")
    add_compile_options(--coverage -O0 -g)
    add_link_options(--coverage)
endif()

# ---------------------------------------------------------------------
# Compiler warnings (target-based)
# ---------------------------------------------------------------------
add_library(project_warnings INTERFACE)

if(ENABLE_WARNINGS)
    if(MSVC)
        target_compile_options(project_warnings INTERFACE /W4 /permissive-)
    else()
        target_compile_options(project_warnings INTERFACE
            -Wall
            -Wextra
            -Wpedantic
        )
    endif()
endif()

message("Building with CMake version: ${CMAKE_VERSION}")

# --------------------------------------------------
# Subdirectories
# --------------------------------------------------
add_subdirectory(${PROJECT_NAME})

# ---------------------------------------------------------------------
# Testing
# ---------------------------------------------------------------------
include(CTest)

if(ENABLE_TESTS AND BUILD_TESTING)
    add_subdirectory(tests)
endif()

# --------------------
# Clang-Tidy integration
# --------------------
find_program(CLANG_TIDY_EXE NAMES "clang-tidy")

if(CLANG_TIDY_EXE)
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
endif()


# ---------------------------------------------------------------------
# Installation (optional but template-ready)
# ---------------------------------------------------------------------
include(GNUInstallDirs)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(
    DIRECTORY ${PROJECT_NAME}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# ---------------------------------------------------------------------
# Packaging support (CPack)
# ---------------------------------------------------------------------
include(CPack)
