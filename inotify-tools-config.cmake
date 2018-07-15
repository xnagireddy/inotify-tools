add_library(inotifytools STATIC IMPORTED)
find_library(INOTIFYTOOLS_LIBRARY_PATH inotifytools HINTS "${CMAKE_CURRENT_LIST_DIR}/../../")
set_target_properties(inotifytools PROPERTIES IMPORTED_LOCATION "${INOTIFYTOOLS_LIBRARY_PATH}")

