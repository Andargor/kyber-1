CXX = g++
CXXFLAGS = -std=c++20 -Wall -Wextra -pedantic
OPTFLAGS = -O3 -march=native -mtune=native
IFLAGS = -I ./include
DEP_IFLAGS = -I ./sha3/include -I ./subtle/include

all: test

tests/a.out: tests/main.cpp include/*.hpp include/tests/*.hpp sha3/include/*.hpp subtle/include/*.hpp
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $(IFLAGS) $(DEP_IFLAGS) $< -o $@

test: tests/a.out
	./$<

benchmarks/a.out: benchmarks/main.cpp include/*.hpp include/benchmarks/*.hpp sha3/include/*.hpp subtle/include/*.hpp
	# make sure you've google-benchmark globally installed;
	# see https://github.com/google/benchmark/tree/3b19d722#installation
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $(IFLAGS) $(DEP_IFLAGS) $< -lbenchmark -o $@

benchmark: benchmarks/a.out
	./$< --benchmark_time_unit=us --benchmark_counters_tabular=true


clean:
	find . -name '*.out' -o -name '*.o' -o -name '*.so' -o -name '*.gch' | xargs rm -rf

format:
	find . -name '*.hpp' -o -name '*.cpp' -o -name '*.hpp' | xargs clang-format -i --style=Mozilla
