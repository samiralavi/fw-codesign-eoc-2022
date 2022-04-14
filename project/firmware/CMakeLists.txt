cmake_minimum_required(VERSION 3.21)

# set the project name
project(firmware VERSION 0.1
        DESCRIPTION "Firmware."
        LANGUAGES C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})

if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found")
endif()


# SystemC dependencies
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

# Find SystemC using SystemC's CMake integration
find_package(SystemCLanguage REQUIRED)

add_executable(firmware 
                src/main.cpp
                )

set_property(
  TARGET firmware
  PROPERTY CXX_STANDARD ${SystemC_CXX_STANDARD}
  )

target_link_libraries(firmware PUBLIC SystemC::systemc component)

verilate(firmware SYSTEMC TRACE COVERAGE
  INCLUDE_DIRS 
  ${PROJECT_BINARY_DIR}/../component/component

  SOURCES src/top.v
  VERILATOR_ARGS -Wno-fatal -Os -x-assign 0)

verilator_link_systemc(firmware)

# install
install(TARGETS firmware DESTINATION bin)
