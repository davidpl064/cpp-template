# Find testing framework (example: GoogleTest)
# With Conan + CMakeDeps, this comes from find_package
find_package(GTest REQUIRED)

# Test executable
add_executable(${PROJECT_NAME}_tests
    test_main.cpp
)

# Link against the main library and GTest
target_link_libraries(${PROJECT_NAME}_tests
    PRIVATE
        ${PROJECT_NAME}
        GTest::gtest
        GTest::gtest_main
)

# Register tests with CTest
include(GoogleTest)
gtest_discover_tests(${PROJECT_NAME}_tests)