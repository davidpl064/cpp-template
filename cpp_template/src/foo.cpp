#include <iostream>

#include "foo.hpp"

// A simple test function
std::string hello_message(const std::string& build_type, const std::string& extra_info) {
    std::string ret = std::string("hello/1.0: Hello World ") + build_type + std::string("! (") +
                      extra_info + std::string(")\n");
    return ret;
}

void hello() {
    std::cout << hello_message("Release", "without color");
}