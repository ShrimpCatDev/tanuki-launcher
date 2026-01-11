lg=love.graphics

function drawElement(x,y,w,func)
    lg.push()
        lg.translate(x,y)
        lg.scale(w,w)
            func()
        lg.translate(0,0)
    lg.pop()
end

function love.load()
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
    bg=lg.newImage("assets/bg/test.png")
end

function love.update(dt)

end

function love.draw()
    lg.clear(color("#f5f5f5"))
    lg.setColor(1,1,1,1)
    lg.draw(bg)
    drawElement(16,16,1,function()
        local txt=os.date("%H:%M")
        lg.setColor(color("#bebebeff"))
        lg.rectangle("fill",0,0,font:getWidth(txt)+32,font:getHeight()+4,8,8)
        lg.setColor(color("#292b31ff"))
        lg.print(txt,2,2)
    end)
    
end

function love.resize(w,h)

end