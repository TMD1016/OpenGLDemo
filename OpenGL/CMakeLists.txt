#cmake_minimum_required(VERSION 3.28)
#project(OpenGL)
#
#set(CMAKE_CXX_STANDARD 17)
#
#add_executable(OpenGL main.cpp)

cmake_minimum_required(VERSION 3.23)
project(OpenGL)

set(CMAKE_CXX_STANDARD 14)

add_executable(OpenGL main.cpp src/glad.c
        include/tool/shader.h)
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
link_directories(${PROJECT_SOURCE_DIR}/lib)
target_link_libraries(OpenGL ${PROJECT_SOURCE_DIR}/lib/glfw3.dll)
