#!/bin/bash

# This is the main script. HPX and the benchmark are downloaded and built.
# Then the benchmark is ran and the results are collected. This proccess 
# is repeated for a list of branches, so that the performance across 
# them can be compared.
# This is useful to compare current and past performance (or to make a
# new branch with some change and benchmark it) in bulk.


branches=(
    # master
    aa8143a28f9c29d27861250e53ef58f0917c6973
    5ea3f434fe5c23c426e0c7f546445b5606db9750
    # 1.8.1
    # 1.8.0
    # 1.7.1

)

mkdir -p collected_results

for branch in ${branches[@]}
do
  echo "Starting fetch_n_bench for branch '$branch'"
  bash get_hpx.sh $branch 
  bash get_bench.sh
  bash run_benchmark.sh
  mv benchmark/results.csv collected_results/$branch.csv
done