#!/bin/bash

export EMCC_CFLAGS="-O2"
export ZLIB_PKGVER=1.2.8
export ZLIB_DIRECTORY="zlib-${ZLIB_PKGVER}"
export LIBTIFF_PKGVER=4.0.3
export LIBTIFF_DIRECTORY="tiff-${LIBTIFF_PKGVER}"
export PATCHES_DIRECTORY="../../patches/"
export WORKSPACE="workspace/"
export DIST="dist/"
export LIB_DIR="lib/"
export WRAPPER_DIR="${LIB_DIR}wrapper/"
export EXPORT_FUNCTION="['_TIFFOpen','_TIFFClose','_TIFFGetField','_TIFFReadRGBAImage','_TIFFReadRGBAImageOriented','_TIFFSetDirectory','_TIFFCurrentDirectory','_TIFFReadDirectory','__TIFFmalloc','__TIFFfree','_GetField','FS']"

if [ ! -d "${WORKSPACE}" ]; then
  mkdir workspace
fi

./bin/zlib.sh
./bin/libtiff.sh

emcc -o ${WORKSPACE}tiff.raw.js \
    --pre-js ${WRAPPER_DIR}pre.js \
    --post-js ${WRAPPER_DIR}post.js \
    -s EXPORTED_FUNCTIONS="${EXPORT_FUNCTION}"\
    ${LIB_DIR}export.c \
    ${WORKSPACE}${LIBTIFF_DIRECTORY}/libtiff/.libs/libtiff.a \
    ${WORKSPACE}${ZLIB_DIRECTORY}/libz.a

./bin/tifftag.sh

nodejs bin/build.js
cat LICENSE ${WORKSPACE}tiff.raw.js > ${DIST}tiff.js
echo '' >> ${DIST}tiff.js
cat ${WORKSPACE}tiff_tag.js ${WORKSPACE}tiff_api.js >> ${DIST}tiff.js
#mv tiff_api.d.ts tiff.d.ts
#rm -f tiff_tag.d.ts tiff_tag.js tiff_api.js

closure-compiler \
    --js=${DIST}tiff.js \
    --js_output_file=${DIST}tiff.min.js \
    --language_in ECMASCRIPT5 \
    --output_wrapper="(function() {%output%})();" \
    --warning_level=QUIET
