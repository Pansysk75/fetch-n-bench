#!/bin/bash

# Define a function for error checking
check_error() {
  # Check the exit status of the previous command, and display an error message if it failed
  if [ $? -ne 0 ]; then
    echo "Failed to $1"
    exit 1
  fi
}

# Use the first command-line argument as the branch to clone, or use the default value of "master"
branch=${1:-master}

# Enable the `errexit` option to exit immediately if a command returns a non-zero exit status
set -e

# Change to the directory containing the script
cd "$(dirname "$0")"

if ! test -d hpx; then
        echo "Cloning HPX from GitHub"
        git clone -b "$branch" https://github.com/STEllAR-GROUP/hpx.git
        check_error "clone the HPX repository from GitHub"
else
        echo "An hpx directory was found, attempting to build it"
fi

# Change to the build directory
cd hpx
mkdir -p build
cd build

# Run CMake to configure the HPX build
cmake -DHPX_WITH_FETCH_ASIO=ON \
      -DHPX_WITH_TESTS_BENCHMARKS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=../install/ \
      -GNinja \
      ..
      
check_error "configure the HPX build with CMake"

# Build and install
cmake --build .
check_error "build the HPX library"

cmake --install .
check_error "install the HPX library"