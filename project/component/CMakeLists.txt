cmake_minimum_required(VERSION 3.21)

# set the project name
project(component VERSION 0.1
        DESCRIPTION "Verilog component."
        LANGUAGES C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})

if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found")
endif()

add_library(component STATIC)

# SystemC dependencies
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

# Find SystemC using SystemC's CMake integration
find_package(SystemCLanguage REQUIRED)

set_property(
  TARGET component
  PROPERTY CXX_STANDARD ${SystemC_CXX_STANDARD}
  )

# Setup random seed
verilator_generate_key(KEY_INIT)
set(PROTECT_KEY ${KEY_INIT} CACHE STRING "Random seed for protection")

verilate(component
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/component
  SOURCES src/secret_impl.v 
  VERILATOR_ARGS -Wno-fatal -Os -x-assign 0 
  --protect-lib component
  --protect-key ${PROTECT_KEY})

install(TARGETS component)
