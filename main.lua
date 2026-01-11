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

function love.load()

    theme=require("themes")

    color=require("lib/hex2color")
    local baton=require("lib/baton")
    input = baton.new ({
    controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        action = {'key:x', 'button:a'},
    },
    pairs = {
        move = {'left', 'right', 'up', 'down'}
    },
    joystick = love.joystick.getJoysticks()[1],
    })

    --os.execute("flatpak run org.libretro.RetroArch")
    love.window.setMode(800,600,{resizable=true})
    font=lg.newFont("assets/font/contb.ttf",32)
    lg.setFont(font)
    --bg=lg.newImage("assets/bg/test.png")
    fade=lg.newShader("shaders/fade.glsl")

    local w,h=love.window.getMode( )
    bg=lg.newCanvas(w,h)
end

function love.update(dt)
    input:update()
    fade:send("time",love.timer.getTime())
end

function love.draw()
    lg.clear(color(theme.light.bg2))
    
    lg.setCanvas(bg)
        lg.setColor(color(theme.light.bg1))
        lg.rectangle("fill",0,0,bg:getWidth(),bg:getHeight())
    lg.setCanvas()

    lg.setShader(fade)
        cImg(bg)
    lg.setShader()
    drawElement(16,16,1,function()
        local txt=os.date("%H:%M")
        lg.setColor(color("#ffffff"))
        lg.setShader(fade)
        lg.rectangle("fill",0,0,font:getWidth(txt)+32,font:getHeight()+4,16,16)
        lg.setShader()
        lg.setColor(color("#292b31ff"))
        lg.print(txt,2,2)
    end)
    
end

function love.resize(w,h)
    bg=lg.newCanvas(w,h)
end