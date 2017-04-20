CXX = g++
LIB = -lglfw -lGL -lGLEW -lGLU -lfftw3 -lfftw3_omp -lpulse-simple -lpthread -lpulse -lm
INCLUDE = -I/usr/include/libdrm -I/usr/include/GL -I/usr/include/pulse -Ifftwpp
CXXFLAGS = -Wall -c -Ofast -std=c++17 -Wno-switch $(INCLUDE)
# CXXFLAGS = -Wall -c -O0 -g -std=c++17 -Wno-switch $(INCLUDE)
EXE = main

all: $(EXE)

$(EXE): main.o draw.o pulse.o fftw++.o
	$(CXX) -fopenmp  $^ $(LIB) -o $@ 

fftw++.o: fftwpp/fftw++.cc
	$(CXX) -fopenmp $(CXXFLAGS) $< -o $@

draw.o: draw.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

pulse.o: pulse.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

main.o: main.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

clean:
	rm *.o && rm $(EXE)