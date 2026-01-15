########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(cpp-template_COMPONENT_NAMES "")
if(DEFINED cpp-template_FIND_DEPENDENCY_NAMES)
  list(APPEND cpp-template_FIND_DEPENDENCY_NAMES ZLIB)
  list(REMOVE_DUPLICATES cpp-template_FIND_DEPENDENCY_NAMES)
else()
  set(cpp-template_FIND_DEPENDENCY_NAMES ZLIB)
endif()
set(ZLIB_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(cpp-template_PACKAGE_FOLDER_RELEASE "/home/dplamarca/.conan2/p/b/cpp-te4b67e222bcd2/p")
set(cpp-template_BUILD_MODULES_PATHS_RELEASE )


set(cpp-template_INCLUDE_DIRS_RELEASE "${cpp-template_PACKAGE_FOLDER_RELEASE}/include")
set(cpp-template_RES_DIRS_RELEASE )
set(cpp-template_DEFINITIONS_RELEASE )
set(cpp-template_SHARED_LINK_FLAGS_RELEASE )
set(cpp-template_EXE_LINK_FLAGS_RELEASE )
set(cpp-template_OBJECTS_RELEASE )
set(cpp-template_COMPILE_DEFINITIONS_RELEASE )
set(cpp-template_COMPILE_OPTIONS_C_RELEASE )
set(cpp-template_COMPILE_OPTIONS_CXX_RELEASE )
set(cpp-template_LIB_DIRS_RELEASE "${cpp-template_PACKAGE_FOLDER_RELEASE}/lib")
set(cpp-template_BIN_DIRS_RELEASE )
set(cpp-template_LIBRARY_TYPE_RELEASE STATIC)
set(cpp-template_IS_HOST_WINDOWS_RELEASE 0)
set(cpp-template_LIBS_RELEASE cpp_template)
set(cpp-template_SYSTEM_LIBS_RELEASE )
set(cpp-template_FRAMEWORK_DIRS_RELEASE )
set(cpp-template_FRAMEWORKS_RELEASE )
set(cpp-template_BUILD_DIRS_RELEASE )
set(cpp-template_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(cpp-template_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${cpp-template_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${cpp-template_COMPILE_OPTIONS_C_RELEASE}>")
set(cpp-template_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cpp-template_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cpp-template_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cpp-template_EXE_LINK_FLAGS_RELEASE}>")


set(cpp-template_COMPONENTS_RELEASE )