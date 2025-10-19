cmake_minimum_required(VERSION 3.10)

project(Project1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Main executable
add_executable(Project1 
    main.cpp
    math_operations.cpp
)

# GoogleTest support
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/heads/main.zip
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

# Unit test executable
add_executable(unit_tests
    tests/unit_tests.cpp
    math_operations.cpp
)

target_link_libraries(unit_tests
    gtest_main
)

target_include_directories(unit_tests PRIVATE ${gtest_SOURCE_DIR}/include)

include(GoogleTest)
gtest_discover_tests(unit_tests)

# -----------------------------------------------------------------------------
# Instructions:
# 1. Configure and build the project:
#    cmake -S . -B build
#    cmake --build build
#
# 2. The test executable will be in the build directory.
#
# 3. To run all tests:
#    cd build
#    ctest
#    # or run the test binary directly:
#    ./unit_tests
# -----------------------------------------------------------------------------