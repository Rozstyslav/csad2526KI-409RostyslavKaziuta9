cmake_minimum_required(VERSION 3.10)

project(lab1 VERSION 1.0 LANGUAGES CXX)

# Compiler settings
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Optionally disable tests from being configured
option(BUILD_TESTS "Build unit tests" ON)

# Build the main library from the implementation so it can be linked by targets
add_library(math_operations STATIC
  math_operations.cpp
)
target_include_directories(math_operations
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
)

# Main executable
add_executable(lab1
  main.cpp
)
target_link_libraries(lab1
  PRIVATE math_operations
)

# Unit tests
if(BUILD_TESTS)
  enable_testing()
  include(FetchContent)

  FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/heads/main.zip
    # Ensure extracted files get the timestamp of extraction (avoids CMP0135 warning)
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  )
  # For Windows: Prevent overriding the parent project's compiler/linker settings
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(googletest)

  add_executable(unit_tests
    unit_tests.cpp
  )
  target_link_libraries(unit_tests
    PRIVATE gtest_main math_operations
  )

  # Register the test with CTest and enable GoogleTest discovery integration
  include(GoogleTest)
  gtest_discover_tests(unit_tests)
  add_test(NAME UnitTests COMMAND unit_tests)
endif()

