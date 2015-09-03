#!/bin/sh

# directory in which to perform the build-process
BUILD_DIR="./bin/testapp"
# directory in which the source files that should be compiled are located
# (relative to BUILD_DIR)
SOURCE_DIR="../../ParaView-TestApp"
# directory in which paraview was built (relative to BUILD_DIR)
PARAVIEW_DIR="$PWD/bin/paraview-bin"
echo $PARAVIEW_DIR

# make sure the build folder exists
echo "creating and switching to bin directory"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# run configuration
echo "running cmake from $PWD"
cmake -D ParaView_DIR="$PARAVIEW_DIR" "$SOURCE_DIR"

# build testapp
echo "building app"
make
