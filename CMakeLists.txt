project(Enlightenment NONE)
cmake_minimum_required(VERSION 3.3) 

include(cmake_modules/mcresourcepack.cmake)
include(cmake_modules/mcresourcepack_ctm.cmake)

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set (CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/" CACHE PATH "The path in which the pack will be installed." FORCE )
endif()

add_subdirectory(src)
