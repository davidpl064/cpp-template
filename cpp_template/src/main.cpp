#include "foo.hpp"
#include <iostream>

int main() {
    std::cout << "=== C++ template build test ===\n";

// Call a test function from the library
#ifdef NDEBUG
    std::cout << hello_message("Release prueba", "without color");
#else
    std::cout << hello_message("Debug", "without color");
#endif

    return 0;
}