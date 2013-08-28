(function() {
  var Asciify, Webcam;

  Webcam = (function() {
    function Webcam() {
      var vendorURL, video;
      vendorURL = window.URL || windon.webkitURL;
      navigator.getMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
      video = document.createElement('video');
      video.setAttribute('autoplay', '1');
      video.setAttribute('width', '320px');
      video.setAttribute('height', '240px');
      video.setAttribute('style', 'display:none');
      document.body.appendChild(video);
      navigator.getMedia({
        video: true,
        audio: false
      }, function(stream) {
        if (navigator.mozGetUserMedia) {
          video.mozSrcObject = stream;
        } else {
          video.src = vendorURL ? vendorURL.createObjectURL(stream) : stream;
        }
        return video.play();
      }, function(error) {
        return console.log(error);
      });
      this.video = video;
    }

    Webcam.prototype.getVideo = function() {
      return this.video;
    };

    return Webcam;

  })();

  Asciify = (function() {
    function Asciify() {}

    Asciify.prototype.process = function(ctx) {
      var alpha, blue, brightness, charIndex, charList, green, height, imageData, offset, outputString, red, width, x, y, _i, _j;
      charList = "              .,:;i1tfLCG08@".split("");
      outputString = "";
      height = parseInt(ctx.canvas.height);
      width = parseInt(ctx.canvas.width);
      imageData = ctx.getImageData(0, 0, width, height).data;
      for (y = _i = 0; 0 <= height ? _i < height : _i > height; y = 0 <= height ? ++_i : --_i) {
        for (x = _j = 0; 0 <= width ? _j < width : _j > width; x = 0 <= width ? ++_j : --_j) {
          offset = (y * width + x) * 4;
          red = imageData[offset];
          green = imageData[offset + 1];
          blue = imageData[offset + 2];
          alpha = imageData[offset + 3];
          brightness = (0.3 * red + 0.59 * green + 0.11 * blue) / 255;
          charIndex = (charList.length - 1) - Math.round(brightness * (charList.length - 1));
          outputString += charList[charIndex];
        }
        outputString += "\n";
      }
      return outputString;
    };

    return Asciify;

  })();

  window.onload = function() {
    var asciify, canvas, ctx, draw, height, webcam, width;
    webcam = new Webcam();
    asciify = new Asciify();
    width = 80;
    height = 40;
    canvas = document.createElement('canvas');
    canvas.setAttribute('width', width);
    canvas.setAttribute('height', height);
    canvas.setAttribute('style', 'display: none');
    document.body.appendChild(canvas);
    ctx = canvas.getContext('2d');
    draw = function() {
      var error, video;
      video = webcam.getVideo();
      if (video.readyState === video.HAVE_ENOUGH_DATA) {
        try {
          ctx.drawImage(video, 0, 0, width, height);
        } catch (_error) {
          error = _error;
          console.log(error);
        } finally {
          document.getElementById('you').innerHTML = asciify.process(ctx);
        }
      }
      return setTimeout(draw, 100);
    };
    return setTimeout(draw, 100);
  };

}).call(this);
