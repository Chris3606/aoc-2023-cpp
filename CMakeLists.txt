cmake_minimum_required(VERSION 3.15)
project(aoc2023 VERSION 0.1.0 LANGUAGES C CXX)

######## Options ########

set(CMAKE_C_STANDARD 99) # Required for MSVC support
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(ENABLE_STRICT_WARNINGS "Whether to enable strict warnings when compiling." ON)
option(ENABLE_ADDRESS_SANITIZER "Whether to enable address sanitizer when compiling." ON)
option(ENABLE_UNDEF_SANITIZER "Whether to enable undefined behavior sanitizer when compiling, if available." ON)
option(ENABLE_LEAK_SANITIZER "Whether to enable leak sanitizer when compiling, if available." ON)
option(ENABLE_THREAD_SANITIZER "Whether to enable thread sanitizer when compiling, if available." ON)

###### End Options ######

# CMake modules
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/)
include(Sanitizers)
include(Warnings)

# Get compiler directory
get_filename_component(COMPILER_DIR ${CMAKE_C_COMPILER} DIRECTORY)

# Add subdirectories for each day and shared code
add_subdirectory(shared)
add_subdirectory(day00)
add_subdirectory(day01)