var tsc = require('typescript-compiler'),
    fs = require('fs');

tsc.compile(['lib/typescript/emscripten.d.ts', 'lib/typescript/tiff_tag.ts', 'lib/typescript/tiff_api.ts'], ['-d']);

fs.renameSync('lib/typescript/tiff_tag.js', 'workspace/tiff_tag.js');
fs.renameSync('lib/typescript/tiff_api.js', 'workspace/tiff_api.js');

