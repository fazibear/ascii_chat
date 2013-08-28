class Webcam
  constructor: ->
    vendorURL = window.URL || window.webkitURL
    @getMedia = navigator.getMedia = navigator.getUserMedia ||
               navigator.webkitGetUserMedia ||
               navigator.mozGetUserMedia ||
               navigator.msGetUserMedia
    
    @video = video = document.createElement 'video'
    video.setAttribute 'autoplay' , '1'
    video.setAttribute 'width', '320px'
    video.setAttribute 'height', '240px'
    video.setAttribute 'style', 'display:none'
    document.body.appendChild(video)
    
    navigator.getMedia(
      {
        video: true,
        audio: false
      }
      (stream) ->
        if navigator.mozGetUserMedia
          video.mozSrcObject = stream
        else
          video.src = if vendorURL then vendorURL.createObjectURL(stream) else stream
        video.play()
      (error) ->
        console.log error
    )

  getVideo: ->
    @video

  isSupported: ->
    @getMedia != 'undefined'
