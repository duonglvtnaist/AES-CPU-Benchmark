cmake_minimum_required(VERSION 3.12)

project(tiny-aes C)

add_library(${PROJECT_NAME} "")
target_sources(${PROJECT_NAME}
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/aes.c
    INTERFACE
        ${CMAKE_CURRENT_LIST_DIR}/aes.h
        ${CMAKE_CURRENT_LIST_DIR}/aes.hpp
)

target_include_directories(${PROJECT_NAME}
    INTERFACE
        ${CMAKE_CURRENT_LIST_DIR}
)


# Add the test executable
add_executable(test_aes ${CMAKE_CURRENT_LIST_DIR}/test.c)
target_link_libraries(test_aes PRIVATE ${PROJECT_NAME} rt)