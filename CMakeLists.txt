cmake_minimum_required(VERSION 3.2)

project(inotify-tools)

include(ExternalProject)

ExternalProject_Add(
    inotify-tools
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    CONFIGURE_COMMAND ./autogen.sh
    COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND make
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make install
)

install(TARGETS DESTINATION ${CMAKE_INSTALL_PREFIX})

#[[
install(
    TARGETS ${}/libinotifytools/src/.libs/libinotifytools.a
    DESTINATION ${CMAKE_INSTALL_PREFIX}
)
]]

