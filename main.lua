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

function love.load()

    theme=require("themes")
    currentTheme=theme.light
    
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
    love.window.setMode(1280,800,{resizable=true})
    font=lg.newFont("assets/font/contb.ttf",32)
    lg.setFont(font)

    fade=lg.newShader("shaders/fade.glsl")

    local w,h=love.window.getMode( )
    bg={img=lg.newCanvas(w,h),spd=8,img2=lg.newCanvas(w,h)}
    timer.tween(1,bg,{spd=0.5},"out-cubic")

    icon=lg.newImage("assets/icons/retroarch.png")
    icon2=lg.newImage("assets/icons/retroarch2.png")

    items={
        {
            name="Retroarch",
            launch="flatpak run org.libretro.RetroArch"
        }
    }

    target={w=1280,h=800}
    local w,h=love.window.getMode( )
    scale=math.min(w/target.w,h/target.h)

    music=love.audio.newSource("assets/music.wav","stream")
    music:setLooping(true)
    music:play()
end

function love.update(dt)
    timer.update(dt)
    input:update()
    fade:send("time",love.timer.getTime()*bg.spd)

    if input:pressed("action") then
        print("launching "..items[1].name)
        os.execute(items[1].launch)
    end
end
-- ...existing code...

function love.draw()
    local w,h=love.window.getMode( )

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

    drawElement(34,32,1,function()
        local txt=os.date("%H:%M")
        lg.setColor(color(currentTheme.ui))
        lg.rectangle("fill",0,0,font:getWidth(txt)+32,font:getHeight()+4,16,16)
        lg.setColor(color(currentTheme.text))
        lg.print(txt,16,2)
    end)

    
    lg.setColor(color(currentTheme.ui))

    local c=color(currentTheme.ui)
    
    lg.setColor(c[1],c[2],c[3],0.4)

    lg.rectangle("fill",64,128,w-128,h-256,16,16)

    lg.setColor(1,1,1,1)
    local s=scaled(icon,128)
    print(icon:getWidth()*s)
    lg.draw(icon,64,64,0,s,s)


    lg.setColor(color(currentTheme.text))
    lg.print(items[1].name,64+16,128+16)

    
end

function love.resize(w,h)
    bg.img=lg.newCanvas(w,h)
    local w,h=love.window.getMode( )
    scale=math.min(w/target.w,h/target.h)
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