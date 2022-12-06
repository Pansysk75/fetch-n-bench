#!/bin/bash

# Change to the directory containing the benchmark
cd "$(dirname "$0")/benchmark"

# Launch the benchmark (this is temporary)
python3 run.py

# Plot the results (this is temporary)
python3 plot.py
