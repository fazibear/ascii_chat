window.onload = ->
  webcam = new Webcam()
  asciify = new Asciify()
  
  width = 80
  height = 40
  
  canvas = document.createElement 'canvas'
  canvas.setAttribute 'width', width
  canvas.setAttribute 'height', height
  canvas.setAttribute 'style', 'display: none'
  document.body.appendChild(canvas)
  ctx = canvas.getContext('2d')
  draw = ->
    video = webcam.getVideo()
    if video.readyState == video.HAVE_ENOUGH_DATA
      try
        ctx.drawImage(video, 0 ,0,width, height)
      catch error
        console.log error
      finally
        document.getElementById('you').innerHTML = asciify.process ctx
    setTimeout(draw, 100)
  setTimeout(draw, 100)

