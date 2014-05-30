#!/bin/bash

export ZLIB_PKGVER=1.2.8
export ZLIB_DIRECTORY="zlib-${ZLIB_PKGVER}"

# build zlib
cd workspace
if [ ! -f "${ZLIB_DIRECTORY}.tar.gz" ]; then
  echo "Download zlib"
  wget -q http://zlib.net/current/${ZLIB_DIRECTORY}.tar.gz
fi
if [ -d "${ZLIB_DIRECTORY}" ]; then
  rm -rf $ZLIB_DIRECTORY
fi
echo "Extract zlib"
tar xf ${ZLIB_DIRECTORY}.tar.gz > /dev/null
cd ${ZLIB_DIRECTORY}
echo "Build zlib"
emconfigure ./configure > ../zlib.configure.log
emmake make > ../zlib.make.log

cd ../..
