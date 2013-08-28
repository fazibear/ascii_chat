window.onload = ->
 
  sendButton = document.getElementById 'send'
  youPre = document.getElementById 'you'
  chatPre = document.getElementById 'chat'
  countSpan = document.getElementById 'count'
  messageInput = document.getElementById 'message'

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
        youPre.innerHTML = asciify.process ctx
    setTimeout(draw, 100)
  setTimeout(draw, 100)

  socket = io.connect 'http://localhost:8080'
  socket.on 'count', (data) ->
    countSpan.innerHTML = data['count']
  socket.on 'message', (data) ->
    chatPre.innerHTML = asciify.formatMessage data['message'], data['ascii'] + chatPre.innerHTML
  
  sendMessage = ->
    unless messageInput.value == ''
      socket.emit 'message',
        message: messageInput.value
        ascii: youPre.innerHTML
    messageInput.value = ''
  
  sendButton.addEventListener 'click', sendMessage
  messageInput.addEventListener 'keypress', (event) ->
    if event.keyCode == 13
      sendMessage()
