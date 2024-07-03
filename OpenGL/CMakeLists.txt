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
        include/imgui/imgui.cpp
        include/imgui/imgui_demo.cpp
        include/imgui/imgui_draw.cpp
        include/imgui/imgui_impl_glfw.cpp
        include/imgui/imgui_impl_opengl3.cpp
        include/imgui/imgui_tables.cpp
        include/imgui/imgui_widgets.cpp)
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
link_directories(${PROJECT_SOURCE_DIR}/lib)
target_link_libraries(OpenGL ${PROJECT_SOURCE_DIR}/lib/glfw3.dll)

