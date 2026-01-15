########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(cpp-template_FIND_QUIETLY)
    set(cpp-template_MESSAGE_MODE VERBOSE)
else()
    set(cpp-template_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cpp-templateTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${cpp-template_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(cpp-template_VERSION_STRING "0.1.0")
set(cpp-template_INCLUDE_DIRS ${cpp-template_INCLUDE_DIRS_RELEASE} )
set(cpp-template_INCLUDE_DIR ${cpp-template_INCLUDE_DIRS_RELEASE} )
set(cpp-template_LIBRARIES ${cpp-template_LIBRARIES_RELEASE} )
set(cpp-template_DEFINITIONS ${cpp-template_DEFINITIONS_RELEASE} )


# Definition of extra CMake variables from cmake_extra_variables


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${cpp-template_BUILD_MODULES_PATHS_RELEASE} )
    message(${cpp-template_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


