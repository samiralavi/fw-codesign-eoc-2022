FROM verilator/verilator:4.210

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME

# package installations for ubuntu
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential git ca-certificates curl wget autoconf ninja-build \
    bash-completion nano ssh-client gtkwave

# Downloads and installs the latest version of cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-linux-x86_64.sh \
    && chmod +x cmake-3.21.1-linux-x86_64.sh \
    && ./cmake-3.21.1-linux-x86_64.sh --prefix=/usr/local --skip-license

# Building SystemC  from source, version 2.3.3
RUN pwd; git clone --branch 2.3.3 --depth 1 https://github.com/accellera-official/systemc.git systemc
RUN cd systemc \
    && mkdir build \
    && cmake -B build -G Ninja -DCMAKE_CXX_STANDARD=14 -DENABLE_PHASE_CALLBACKS_TRACING=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr/local . \
    && cmake --build build \
    && cmake --build build --target install \
    && rm -rf build

RUN ldconfig;
##############################
