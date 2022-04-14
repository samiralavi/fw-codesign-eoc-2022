# Sample project showcasing SystemC, Verilator, CMake, and GTKWave for SW/HW codesign for Embedded Online Conference 2022

This demo provides a reference example on how a 3rd party verilog IP can be protected by Verilator and being used as a component in another verilated model with SystemC simulation. 

Author: Seyed Amir Alavi @samiralavi, Riverlane, Cambridge, UK.
https://samiralavi.github.io

# Development Environment
The project is using `CMake` for the build system and requires `Verilator` and `SystemC` to be already installed and accessible by CMake. To make the development even easier, a reference VSCode containerized development environment is provided at `.devcontainer/devcontainer.json` that automates installation of the required dependencies. All you need to do is to install `Visual Studio Code Remote Development` extension and open the project inside the container. For further information about this method you can read the guides provided by VSCode at: https://code.visualstudio.com/docs/remote/containers


# Build, Installation and Running
You can follow the standard CMake project build process either on you local machine or inside the container.

```sh
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=fs
make
make install
./fs/bin/main
```

# Project structure
The project is made of two main parts: the hardware component `project/component` in Verilog HDL to be simulated, and the firmware using that component, `project/firmware`. The component is build as an encrypted static library, which gets linked into the firmware during the build time. 