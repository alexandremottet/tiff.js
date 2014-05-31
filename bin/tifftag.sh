#!/bin/bash

echo 'var TiffTag = {' > ${WORKSPACE}tiff_tag.ts
grep '^#define[[:space:]]\+TIFFTAG_[A-Za-z_]\+[[:space:]]\+' \
    ${WORKSPACE}${LIBTIFF_DIRECTORY}/libtiff/tiff.h \
    | sed -e "s@^\#define[[:space:]]*TIFFTAG_\([A-Za-z_]*\)[[:space:]]*\([A-Za-z0-9]*\).*@  \1 : \2,@g" \
    >> ${WORKSPACE}tiff_tag.ts
echo '};' >> ${WORKSPACE}tiff_tag.ts
