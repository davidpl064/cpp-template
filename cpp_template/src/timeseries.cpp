#include "timeseries.hpp"

#include <algorithm>
#include <cmath>
#include <numeric>

namespace timeseries {

std::optional<double> rms(const std::vector<double>& data) {
    if (data.empty()) {
        return std::nullopt;
    }

    double sum_sq = std::accumulate(data.begin(), data.end(), 0.0,
                                    [](double acc, double x) { return acc + x * x; });

    return std::sqrt(sum_sq / data.size());
}

std::vector<double> moving_average(const std::vector<double>& data, std::size_t window_size) {

    if (window_size == 0 || data.size() < window_size) {
        return {};
    }

    std::vector<double> result;
    result.reserve(data.size() - window_size + 1);

    double window_sum = std::accumulate(data.begin(), data.begin() + window_size, 0.0);

    result.push_back(window_sum / window_size);

    for (std::size_t i = window_size; i < data.size(); ++i) {
        window_sum += data[i] - data[i - window_size];
        result.push_back(window_sum / window_size);
    }

    return result;
}

std::vector<double> derivative(const std::vector<double>& data, double dt) {

    if (data.size() < 2 || dt <= 0.0) {
        return {};
    }

    std::vector<double> result;
    result.reserve(data.size() - 1);

    for (std::size_t i = 1; i < data.size(); ++i) {
        result.push_back((data[i] - data[i - 1]) / dt);
    }

    return result;
}

std::vector<double> normalize(const std::vector<double>& data) {

    if (data.empty()) {
        return {};
    }

    auto [min_it, max_it] = std::minmax_element(data.begin(), data.end());

    double range = *max_it - *min_it;
    if (range == 0.0) {
        return std::vector<double>(data.size(), 0.0);
    }

    std::vector<double> result;
    result.reserve(data.size());

    for (double x : data) {
        result.push_back((x - *min_it) / range);
    }

    return result;
}

} // namespace timeseries
