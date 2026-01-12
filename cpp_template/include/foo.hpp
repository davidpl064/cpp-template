#pragma once

#include <iostream>

// A simple test function
inline void say_hello() {
    std::cout << "Hello from " << __FILE__ << "!\n";
}