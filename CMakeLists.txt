cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Disable in source build
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# Project
project(HelloActions
  VERSION 0.1.0
  LANGUAGES CXX)

# Set a default build type if none was specified
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo" "MinSizeRel")
endif ()

# Targets
add_executable(${PROJECT_NAME} main.cpp)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_EXTENSIONS OFF)

# Install
include(GNUInstallDirs)

install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# Package
set(HELLOACTIONS_CPACK_GENERATOR "ZIP" CACHE STRING "Choose CPack generator.")
if (UNIX)
  set_property(CACHE HELLOACTIONS_CPACK_GENERATOR PROPERTY STRINGS "TGZ" "ZIP" "STGZ" "DEB")
else ()
  set_property(CACHE HELLOACTIONS_CPACK_GENERATOR PROPERTY STRINGS "ZIP" "NSIS")
endif ()

set(CPACK_GENERATOR "${HELLOACTIONS_CPACK_GENERATOR}")
set(CPACK_PACKAGE_VENDOR "HelloActions")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Hello, Actions.")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

if (HELLOACTIONS_CPACK_GENERATOR STREQUAL "DEB")
  set(CPACK_DEBIAN_PACKAGE_MAINTAINER "HelloActions")
  set(CPACK_DEBIAN_FILE_NAME "DEB-DEFAULT")
  set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
  # https://stackoverflow.com/a/7363073
  set(CPACK_SET_DESTDIR true)
  set(CPACK_INSTALL_PREFIX /opt/helloactions)
elseif (HELLOACTIONS_CPACK_GENERATOR STREQUAL "NSIS")
  # Start menu entry
  set(CPACK_PACKAGE_EXECUTABLES "HelloActions;HelloActions")
endif ()

# TODO: configure source packages

include(CPack)
