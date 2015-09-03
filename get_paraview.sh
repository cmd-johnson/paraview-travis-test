#!/bin/sh

# root directory of all binaries
BIN_ROOT_DIR="./bin/"

# directory to which the paraview binaries should be symlinked
PARAVIEW_BIN_SYMLINK="paraview-bin"
# directory in which the actual current paraview binaries should be PARAVIEW_BUILD_QT_GUI
PARAVIEW_BIN_DIR="paraview-v4.3.1+02-bin"

# filename of zipped paraview binaries
PARAVIEW_ZIP_FILENAME="pv-binaries-linux.zip"
# url from where to download the paraview binaries
PARAVIEW_BIN_URL="https://github.com/cmd-johnson/paraview-bin/releases/download/v4.3.1%2B02/$PARAVIEW_ZIP_FILENAME"


cd $BIN_ROOT_DIR
# check if the paraview binaries are already exist
if [ -d "$PARAVIEW_BIN_DIR" ];
then
  echo "The needed ParaView version is already available"
else
  echo "ParaView doesn't seem to be available at the version wanted, downloading binaries"
  # create and change to paraview binary directory
  mkdir -p $PARAVIEW_BIN_DIR
  cd $PARAVIEW_BIN_DIR
  # download paraview binaries
  wget $PARAVIEW_BIN_URL
  # unzip paraview binaries
  unzip $PARAVIEW_ZIP_FILENAME -d ./ 1> /dev/null
  # go back to the bin root directory
  cd ..
fi

# make sure the paraview bin symlink points to the paraview bin directory
echo "creating ParaView binary symlink"
# remove the current link if it exists
rm -f $PARAVIEW_BIN_SYMLINK
# create a new link pointing to the paraview bin directory
ln -s $PARAVIEW_BIN_DIR $PARAVIEW_BIN_SYMLINK
