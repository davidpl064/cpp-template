find_package(Git REQUIRED)
# Only try to read Git if .git exists
if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} tag --sort=-v:refname
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_TAGS
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # Take the first line (highest version)
    string(REGEX REPLACE "\r?\n.*" "" GIT_VERSION "${GIT_TAGS}")
    message(STATUS "Git raw version: ${GIT_VERSION}")

    # Strip leading "v"
    string(REGEX REPLACE "^v" "" PROJECT_VERSION ${GIT_VERSION})

    message(STATUS "Project version: ${PROJECT_VERSION}")

    file(WRITE "${CMAKE_SOURCE_DIR}/version.txt" "${PROJECT_VERSION}\n")
else()
    # Package install / consumer mode — read from file or fallback
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/version.txt")
        file(READ "${CMAKE_CURRENT_SOURCE_DIR}/version.txt" PROJECT_VERSION)
        string(STRIP "${PROJECT_VERSION}" PROJECT_VERSION)
        message(STATUS "Project version from version.txt: ${PROJECT_VERSION}")
    else()
        set(PROJECT_VERSION "0.0.0")
        message(WARNING "No Git and no version.txt, defaulting to 0.0.0")
    endif()
endif()
