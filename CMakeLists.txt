cmake_minimum_required(VERSION 3.21)

# set the project name
project(sample_project VERSION 0.1
        DESCRIPTION "EOC 2022 Tutorial Project."
        LANGUAGES C CXX)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_subdirectory(project)
