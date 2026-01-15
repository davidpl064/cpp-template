#include <foo.hpp>

#include "gtest/gtest.h"

namespace {
TEST(BasicTest, HelloTest) {
    EXPECT_EQ(std::string("hello/1.0: Hello World Release! (with color!)\n"),
              hello_message("Release", "with color!"));
    EXPECT_EQ(std::string("hello/1.0: Hello World Debug! (with color!)\n"),
              hello_message("Debug", "with color!"));
    EXPECT_EQ(std::string("hello/1.0: Hello World Release! (without color)\n"),
              hello_message("Release", "without color"));
    EXPECT_EQ(std::string("hello/1.0: Hello World Debug! (without color)\n"),
              hello_message("Debug", "without color"));
}
} // namespace