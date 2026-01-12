#include <iostream>
#include "foo.hpp"

int main() {
    std::cout << "=== C++ template build test ===\n";

    // Call a test function from the library
    say_hello();

    return 0;
}