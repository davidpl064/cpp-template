#pragma once

#include <optional>
#include <vector>

namespace timeseries {

/**
 * @brief Calculate root mean squared (RMS) value of a timeseries or signal.
 *
 * @param data Time array of values.
 * @return std::optional<double> RMS value.
 */
std::optional<double> rms(const std::vector<double>& data);

/**
 * @brief Calculate moving average of input signal according to set window size.
 *
 * @param data Time array of values.
 * @param window_size Number of elements considered on each step.
 * @return std::vector<double> Array of mean values.
 */
std::vector<double> moving_average(const std::vector<double>& data, std::size_t window_size);

/**
 * @brief Compute the time derivate of input signal.
 *
 * @param data Time array of values.
 * @param dt Time step.
 * @return std::vector<double> Array of time derivate signal.
 */
std::vector<double> derivative(const std::vector<double>& data, double dt);

/**
 * @brief Normalize timeseries.
 *
 * @param data Time array of values.
 * @return std::vector<double> Normalized array.
 */
std::vector<double> normalize(const std::vector<double>& data);

} // namespace timeseries
