cmake_minimum_required(VERSION 3.24)

add_executable(openWindow tests/openWindow.cpp)
target_include_directories(openWindow PUBLIC ${Dragon_INCLUDE_DIRS})
target_link_libraries(openWindow PUBLIC Dragon::Dragon)
target_link_libraries(openWindow INTERFACE ${Dragon_LINK_INTERFACES})