#!/bin/bash

export LIBTIFF_PKGVER=4.0.3
export LIBTIFF_DIRECTORY="tiff-${LIBTIFF_PKGVER}"
export PATCHES_DIRECTORY="../../patches/"

# build libtiff
cd workspace
if [ ! -f "${LIBTIFF_DIRECTORY}.tar.gz" ]; then
  echo "Download libtiff"
  wget -q http://download.osgeo.org/libtiff/${LIBTIFF_DIRECTORY}.tar.gz
fi
if [ -d "${LIBTIFF_DIRECTORY}" ]; then
  rm -rf $LIBTIFF_DIRECTORY
fi
echo "Extract libtiff"
tar xf ${LIBTIFF_DIRECTORY}.tar.gz > /dev/null
cd ${LIBTIFF_DIRECTORY}
# see: https://github.com/kripken/emscripten/issues/662
pwd
sudo patch -p0 < ${PATCHES_DIRECTORY}tif_open.c.patch
sudo patch -p0 < ${PATCHES_DIRECTORY}tiff.h.patch
echo "Build libtiff"
emconfigure ./configure --enable-shared  > ../libtiff.configure.log
emmake make > ../libtiff.make.log

cd ../..
