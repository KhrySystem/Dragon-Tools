cmake_minimum_required(VERSION 3.24)

add_executable(openWindow tests/openWindow.cpp)
target_include_directories(openWindow ${Dragon_INCLUDE_DIRS})
target_link_libraries(openWindow PUBLIC ${Dragon_LINK_LIBRARIES})
target_link_libraries(openWindow INTERFACE ${Dragon_LINK_INTERFACES})

find_package(Python REQUIRED)