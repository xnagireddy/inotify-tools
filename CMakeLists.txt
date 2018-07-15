project(inotifytools)

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

install(FILES inotifytoolsConfig.cmake DESTINATION lib/cmake/inotifytools)

