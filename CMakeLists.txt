cmake_minimum_required(VERSION 3.21...3.27 FATAL_ERROR)

# Disable in source build
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# Project
project(PythonTest
  VERSION 0.1.0
  LANGUAGES CXX)

# Set a default build type if none was specified
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo" "MinSizeRel")
endif ()

# Setup FetchContent
include(FetchContent)
mark_as_advanced(FORCE
  FETCHCONTENT_BASE_DIR
  FETCHCONTENT_FULLY_DISCONNECTED
  FETCHCONTENT_QUIET
  FETCHCONTENT_UPDATES_DISCONNECTED)

# pybind11
FetchContent_Declare(pybind11
  URL "https://github.com/pybind/pybind11/archive/v2.11.1.tar.gz"
  URL_HASH SHA256=d475978da0cdc2d43b73f30910786759d593a9d8ee05b1b6846d1eb16c6d2e0c)
FetchContent_GetProperties(pybind11)
if (NOT pybind11_POPULATED)
  message(STATUS "Fetch pybind11 ...")
  FetchContent_Populate(pybind11)
  option(PYBIND11_INSTALL "" OFF)
  option(PYBIND11_TEST "" OFF)
  add_subdirectory(${pybind11_SOURCE_DIR} ${pybind11_BINARY_DIR} EXCLUDE_FROM_ALL)
  mark_as_advanced(FORCE
    FETCHCONTENT_SOURCE_DIR_PYBIND11
    FETCHCONTENT_UPDATES_DISCONNECTED_PYBIND11
    PYBIND11_FINDPYTHON
    PYBIND11_INSTALL
    PYBIND11_INTERNALS_VERSION
    PYBIND11_NOPYTHON
    PYBIND11_PYTHONLIBS_OVERWRITE
    PYBIND11_PYTHON_VERSION
    PYBIND11_SIMPLE_GIL_MANAGEMENT
    PYBIND11_TEST)
endif ()

pybind11_add_module(PythonTest "main.cpp")
target_compile_features(PythonTest PUBLIC cxx_std_20)
set_target_properties(PythonTest PROPERTIES
  CXX_EXTENSIONS OFF
  MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
  OUTPUT_NAME "python_test")

# Tell MSVC all source files are UTF-8 encoded
target_compile_options(PythonTest PRIVATE "$<$<OR:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>:/utf-8>")

install(TARGETS PythonTest
  LIBRARY DESTINATION .)
