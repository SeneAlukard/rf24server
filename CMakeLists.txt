cmake_minimum_required(VERSION 3.12)
project(rfServer CXX)

# Set C++ version
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Add include path
include_directories(${CMAKE_SOURCE_DIR}/include)

# Find all source files in src/
file(GLOB_RECURSE SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")

# Create the executable
add_executable(rfServer ${SOURCES})

# Link RF24 (modify if needed)
target_link_libraries(rfServer rf24)
# Symlink compile_commands.json to project root
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink
            ${CMAKE_BINARY_DIR}/compile_commands.json
            ${CMAKE_SOURCE_DIR}/compile_commands.json
    RESULT_VARIABLE link_result
  )
endif()

