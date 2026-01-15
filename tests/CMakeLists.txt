# Find testing framework (example: GoogleTest)
# With Conan + CMakeDeps, this comes from find_package
find_package(GTest REQUIRED CONFIG)

# Unit Test executable
add_executable(unit_tests
    unit/test_unit.cpp
)

# Link against the main library and GTest
target_link_libraries(unit_tests
    PRIVATE
        ${PROJECT_NAME}
        GTest::gtest
        GTest::gtest_main
)

# Integration Test executable
add_executable(integration_tests
    integration/test_integration.cpp
)

# Link against the main library and GTest
target_link_libraries(integration_tests
    PRIVATE
        ${PROJECT_NAME}
        GTest::gtest
        GTest::gtest_main
)

# Register tests with GTest
include(GoogleTest)
gtest_discover_tests(unit_tests
    LABELS unit
)
gtest_discover_tests(integration_tests
    LABELS integration
    DISCOVERY_TIMEOUT 60
)