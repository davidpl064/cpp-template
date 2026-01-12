# ---------------------------------------------------------------------
# Conan / dependencies (Conan 2 + CMakeDeps + CMakeToolchain)
# ---------------------------------------------------------------------
# Conan generates:
#   - conan_toolchain.cmake
#   - dependency config files (find_package)
#
# Toolchain is passed at configure time:
#   cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
#
# So here we just use find_package()

# Example:
# find_package(fmt REQUIRED)
# find_package(spdlog REQUIRED)

# ---------------------------------------------------------------------
# Main library target
# ---------------------------------------------------------------------
add_library(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
    PRIVATE
        src/main.cpp
)

# Public include directories
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# Link project-wide utilities (warnings, deps, etc.)
find_package(ZLIB REQUIRED)
target_link_libraries(${PROJECT_NAME}
    PUBLIC
        project_warnings
        ZLIB::ZLIB
        # fmt::fmt
        # spdlog::spdlog
)

# Enforce C++ standard at target level
target_compile_features(${PROJECT_NAME}
    PUBLIC cxx_std_23
)

# ---------------------------------------------------------------------
# Executable (optional)
# ---------------------------------------------------------------------
if(ENABLE_EXAMPLES)
    add_executable(${PROJECT_NAME}_app
        src/main.cpp
    )

    target_link_libraries(${PROJECT_NAME}_app
        PRIVATE ${PROJECT_NAME}
    )
endif()