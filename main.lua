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
    currentTheme=theme.dark
    
    timer=require("lib/timer")
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

    fade=lg.newShader("shaders/fade.glsl")

    local w,h=love.window.getMode( )
    bg={img=lg.newCanvas(w,h),spd=8}
    timer.tween(1,bg,{spd=0.5},"out-cubic")
end

function love.update(dt)
    timer.update(dt)
    input:update()
    fade:send("time",love.timer.getTime()*bg.spd)
end

function love.draw()
    lg.clear(color(currentTheme.bg2))
    
    lg.setCanvas(bg.img)
        lg.setColor(color(currentTheme.bg1))
        lg.rectangle("fill",0,0,bg.img:getWidth(),bg.img:getHeight())
    lg.setCanvas()

    lg.push()
    lg.setShader(fade)
        cImg(bg.img)
    lg.setShader()
    lg.pop()

    lg.setColor(1,1,1,1)

    drawElement(16,16,1,function()
        local txt=os.date("%H:%M")
        lg.setColor(color("#ffffff"))
        lg.rectangle("fill",0,0,font:getWidth(txt)+32,font:getHeight()+4,16,16)
        lg.setColor(color("#292b31ff"))
        lg.print(txt,2,2)
    end)
    
end

function love.resize(w,h)
    bg.img=lg.newCanvas(w,h)
end

function love.keypressed(k)
    if k=="f11" then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end
    end
end