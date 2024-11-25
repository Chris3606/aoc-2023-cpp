cmake_minimum_required(VERSION 3.15)
set(TARGET_NAME ${PROJECT_NAME}_day01)

# Add executable target
set(SRC_FILES
    "./src/main.cpp"
    "./src/solution.cpp"
)

set(HDR_FILES
    "./include/solution.hpp"
)
add_executable(${TARGET_NAME} ${SRC_FILES} ${HDR_FILES})

# Enable strict warnings if needed
if (ENABLE_STRICT_WARNINGS)
    Warnings_Enable(${TARGET_NAME})
endif()

# Enable sanitizers as requested
Sanitizers_Enable(${TARGET_NAME} ${ENABLE_ADDRESS_SANITIZER} ${ENABLE_UNDEF_SANITIZER} ${ENABLE_LEAK_SANITIZER} ${ENABLE_THREAD_SANITIZER} ${COMPILER_DIR})

# Configure include directories
target_include_directories(${TARGET_NAME} PRIVATE ./include)

# Link against dependencies
target_link_libraries(${TARGET_NAME} PRIVATE ${PROJECT_NAME}_shared)
