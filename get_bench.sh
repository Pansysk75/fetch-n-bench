#!/bin/bash

# Define a function for error checking
check_error() {
  # Check the exit status of the previous command, and display an error message if it failed
  if [ $? -ne 0 ]; then
    echo "Failed to $1"
    exit 1
  fi
}

# Enable the `errexit` option to exit immediately if a command returns a non-zero exit status
set -e

# Change to the directory containing the script
cd "$(dirname "$0")"

if ! test -d benchmark; then
        echo "Cloning benchmark from GitHub"
        git clone https://github.com/Pansysk75/HPX-Performance-Benchmarks benchmark
        check_error "clone the benchmark repository from GitHub"
else
        echo "A benchmark directory was found, attempting to build it"
fi

# Change to the build directory
cd benchmark
mkdir -p build
cd build

# Run CMake to configure the HPX build
HPX_DIR=../../hpx/install/ \
cmake -DCMAKE_INSTALL_PREFIX=../install/ \
      -GNinja \
      ..
      
check_error "configure the benchmark build with CMake"

# Build and install
cmake --build .
check_error "build the benchmark"

cmake --install .
check_error "install the benchmark library"