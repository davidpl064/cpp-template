#include "timeseries.hpp"

#include <iostream>

/**
 * @brief Template main method running app.
 *
 * @return int Execution code.
 */
int main() {
    std::cout << "=== C++ template app ===\n";

    std::vector<double> data{1.0, 2.0, 4.0, 7.0, 11.0};
    int window_size = 3;

    auto r = timeseries::rms(data);
    if (r) {
        std::cout << "RMS: " << *r << '\n';
    }

    auto avg = timeseries::moving_average(data, window_size);
    auto deriv = timeseries::derivative(data, 1.0);
    auto norm = timeseries::normalize(data);

    std::cout << "Moving average:\n";
    for (double v : avg) {
        std::cout << v << " ";
    }
    std::cout << "\n";

    return 0;
}
