if (!ArrayBuffer.prototype.slice) {
  ArrayBuffer.prototype.slice = function (begin, end) {
    begin = (begin|0) || 0;
    var num = this.byteLength;
    end = end === (void 0) ? num : (end|0);

    // Handle negative values.
    if (begin < 0) begin += num;
    if (end < 0) end += num;

    if (num === 0 || begin >= num || begin >= end) {
      return new ArrayBuffer(0);
    }

    var length = Math.min(num - begin, end - begin);
    var target = new ArrayBuffer(length);
    var targetArray = new Uint8Array(target);
    targetArray.set(new Uint8Array(this, begin, length));
    return target;
  };
}

var loadModule = function (options) {
  var Module = {};

  if ('TOTAL_MEMORY' in options) {
    Module['TOTAL_MEMORY'] = options['TOTAL_MEMORY'];
  }
