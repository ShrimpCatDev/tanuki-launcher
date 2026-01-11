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
    font=love.graphics.newFont("assets/font/contb.ttf")
end

function love.update(dt)

end

function love.draw()
    love.graphics.clear(color("#f5f5f5"))
    love.graphics.setColor(color("#bebebeff"))
    love.graphics.rectangle("fill",0,0,64,16,4,4)
    love.graphics.setColor(color("#292b31ff"))
    love.graphics.print(os.date("%H:%M"))
end

function love.resize(w,h)

end