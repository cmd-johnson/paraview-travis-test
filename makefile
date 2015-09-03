# build rules
all: paraview testapp

# fetches the required ParaView binaries
paraview:
	./get_paraview.sh

# builds the test app
testapp:
	./build_testapp.sh
