# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(cpp-template_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(cpp-template_FRAMEWORKS_FOUND_RELEASE "${cpp-template_FRAMEWORKS_RELEASE}" "${cpp-template_FRAMEWORK_DIRS_RELEASE}")

set(cpp-template_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET cpp-template_DEPS_TARGET)
    add_library(cpp-template_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET cpp-template_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${cpp-template_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${cpp-template_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:ZLIB::ZLIB>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### cpp-template_DEPS_TARGET to all of them
conan_package_library_targets("${cpp-template_LIBS_RELEASE}"    # libraries
                              "${cpp-template_LIB_DIRS_RELEASE}" # package_libdir
                              "${cpp-template_BIN_DIRS_RELEASE}" # package_bindir
                              "${cpp-template_LIBRARY_TYPE_RELEASE}"
                              "${cpp-template_IS_HOST_WINDOWS_RELEASE}"
                              cpp-template_DEPS_TARGET
                              cpp-template_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "cpp-template"    # package_name
                              "${cpp-template_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${cpp-template_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${cpp-template_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${cpp-template_LIBRARIES_TARGETS}>
                 )

    if("${cpp-template_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET cpp_template::cpp_template
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     cpp-template_DEPS_TARGET)
    endif()

    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${cpp-template_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${cpp-template_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${cpp-template_LIB_DIRS_RELEASE}>)
    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${cpp-template_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET cpp_template::cpp_template
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${cpp-template_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(cpp-template_LIBRARIES_RELEASE cpp_template::cpp_template)
