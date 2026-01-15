find_package(Git REQUIRED)

execute_process(
    COMMAND ${GIT_EXECUTABLE} describe --tags --dirty --always
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Strip leading "v"
string(REGEX REPLACE "^v" "" PROJECT_VERSION ${GIT_VERSION})

message(STATUS "Project version: ${PROJECT_VERSION}")