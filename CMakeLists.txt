project(inotify-tools)

cmake_minimum_required(VERSION 3.2)

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

install(FILES inotify-tools-config.cmake DESTINATION lib/cmake/inotify-tools)
install(
    DIRECTORY
    _install/
    DESTINATION
    ${CMAKE_INSTALL_PREFIX}
)

