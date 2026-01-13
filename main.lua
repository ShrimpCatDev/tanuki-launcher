require("init")

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
            launch=[[flatpak run info.cemu.Cemu -g "/run/media/deck/75d203dc-5e2a-48d2-965b-4e7e77ecdf50/Emulation/roms/wiiu/MARIO KART 8 [Game] [000500001010ec00]/code/Turbo.rpx"]]
        }
    }

    target={w=1280,h=800}
    local w,h=love.window.getMode( )
    scale=math.min(w/target.w,h/target.h)

    music=love.audio.newSource("assets/music.wav","stream")
    music:setLooping(true)
    --music:play()

    profile=require("widgets/profile")
    profile:init()

    gs=require("widgets/gameSelect")
    gs:init()
end

function love.update(dt)
    timer.update(dt)
    input:update()
    fade:send("time",love.timer.getTime()*bg.spd)

    if input:pressed("action") then
        print("launching "..items[1].name)
        os.execute(items[1].launch)
    end

    profile:update(dt)
    gs:update(dt)
end

function love.draw()
    local w,h,mew=love.window.getMode( )

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
    profile:draw(w,h)

    gs:draw(w,h)

    lg.setColor(1,1,1,1)
    local s=scaled(icon,128)
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