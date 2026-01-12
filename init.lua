lg=love.graphics

function drawElement(x,y,w,func)
    lg.push()
        lg.translate(x,y)
        lg.scale(w,w)
            func()
        lg.translate(0,0)
    lg.pop()
end

function cImg(img)
    local w,h=love.window.getMode( )
    lg.draw(img,w/2,h/2,0,1,1,img:getWidth()/2,img:getHeight()/2)
end

function scaled(img,ts)
    local iw,ih=img:getDimensions()
    local scale=ts/math.max(iw,ih)
    return scale
end