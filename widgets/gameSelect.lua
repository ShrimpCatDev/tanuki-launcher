local gs={}

function gs:init()

end

function gs:update()

end

function gs:draw(w,h)
    lg.push()
    lg.translate(64,128)
        local c=color(currentTheme.ui)
        lg.setColor(c[1],c[2],c[3],0.4)

        lg.rectangle("fill",0,0,w-128,h-256,16,16)

        lg.setColor(c)
        for x=0,w/128-2 do
            for y=0,h/128-3 do
                lg.circle("fill",x*128+64,y*128+64,2)
            end
        end
    lg.translate(0,0)
    lg.pop()
end

return gs