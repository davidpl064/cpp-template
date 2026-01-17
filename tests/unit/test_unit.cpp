#include <timeseries.hpp>

#include "gtest/gtest.h"

TEST(TimeSeriesTest, RMS) {
    std::vector<double> data{1.0, 1.0, 1.0};
    auto r = timeseries::rms(data);
    ASSERT_TRUE(r.has_value());
    EXPECT_DOUBLE_EQ(*r, 1.0);
}

TEST(TimeSeriesTest, Derivative) {
    std::vector<double> data{0.0, 1.0, 3.0};
    auto d = timeseries::derivative(data, 1.0);

    ASSERT_EQ(d.size(), 2);
    EXPECT_DOUBLE_EQ(d[0], 1.0);
    EXPECT_DOUBLE_EQ(d[1], 2.0);
}
