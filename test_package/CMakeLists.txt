cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

find_package(cpp-template CONFIG REQUIRED)

add_executable(consumer_pkg src/consumer.cpp)
target_link_libraries(consumer_pkg cpp_template::cpp_template)