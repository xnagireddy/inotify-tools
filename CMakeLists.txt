cmake_minimum_required(VERSION 3.2)

project(inotifytools VERSION 3.20.1)

include(ExternalProject)

ExternalProject_Add(
    inotify-tools-autotools
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    CONFIGURE_COMMAND ./autogen.sh
    COMMAND ./configure --prefix=${CMAKE_CURRENT_SOURCE_DIR}/_install
    BUILD_COMMAND make
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make install
)

add_library(inotifytools libinotifytools/src/inotifytools/inotifytools.h libinotifytools/src/inotifytools.c)
add_dependencies(inotifytools inotify-tools-autotools)

target_include_directories(
    inotifytools
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>"
)

set(config_install_dir "lib/cmake/${PROJECT_NAME}")
set(include_install_dir "include")

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")

set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}::")

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${version_config}" COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
)

#[[
install(FILES inotify-tools-config.cmake DESTINATION lib/cmake/inotify-tools)
install(
    DIRECTORY
    _install/
    DESTINATION
    ${CMAKE_INSTALL_PREFIX}
)
]]

install(
    TARGETS inotifytools
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    RUNTIME DESTINATION "bin"
    INCLUDES DESTINATION "${include_install_dir}"
)

install(
    FILES libinotifytools/src/inotifytools/inotifytools.h
    DESTINATION "${include_install_dir}/inotifytools"
)

install(
    FILES "${project_config}" "${version_config}"
    DESTINATION "${config_install_dir}"
)

install(
    EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE "${namespace}"
    DESTINATION "${config_install_dir}"
)



