requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl: '../dist', 
    paths: {
    	jquery: '../bower_components/jquery/dist/jquery.min'
    },
});

require(["jquery","tiff"], function($,Tiff) {

	Tiff.initialize({TOTAL_MEMORY:16777216*10})

	$(function () {
	  var imageFiles = [
	    '01.tiff'
	  ];

	  var loadImage = function (filename) {
	    var xhr = new XMLHttpRequest();
	    xhr.open('GET', filename);
	    xhr.responseType = 'arraybuffer';
	    xhr.onload = function (e) {
	      var buffer = xhr.response;
	      var tiff = new Tiff({buffer: buffer});
	      var canvas = tiff.toCanvas();
	      var width = tiff.width();
	      var height = tiff.height();
	      if (canvas) {
	        var $elem = $('<div><div><a href="' + filename + '">' +
	                      filename +
	                      ' (width: ' + width + ', height:' + height + ')' +
	                      '</a></div></div>');
	        $elem.append(canvas);
	        $('body').append($elem);
	      }
	    };
	    xhr.send();
	  };

	  for (var i = 0, len = imageFiles.length; i < len; ++i) {
	    loadImage('images/' + imageFiles[i]);
	  }
	});
	
});
