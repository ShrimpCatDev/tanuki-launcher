local gs={}

function gs:init()

end

function gs:update()

end

function gs:draw(w,h)
    local c=color(currentTheme.ui)
    lg.setColor(c[1],c[2],c[3],0.4)

    lg.rectangle("fill",64,128,w-128,h-256,16,16)

end

return gs