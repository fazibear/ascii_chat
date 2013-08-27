class Asciify
  process: (ctx) ->
    charList = "              .,:;i1tfLCG08@".split("")
    outputString = ""
    height = parseInt(ctx.canvas.height)
    width = parseInt(ctx.canvas.width)
    imageData = ctx.getImageData(0,0,width,height).data
    
    for y in [0...height]
      for x in [0...width]
        offset = (y * width + x) * 4
      
        red   = imageData[offset]
        green = imageData[offset + 1]
        blue  = imageData[offset + 2]
        alpha = imageData[offset + 3]

        brightness = (0.3 * red + 0.59 * green + 0.11 * blue) / 255
        charIndex = (charList.length - 1) - Math.round(brightness * (charList.length - 1))
        
        outputString += charList[charIndex]
      outputString += "\n"
    outputString
