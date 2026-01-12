local gs={}

function gs:init()
    self.icons={
        {
            img=lg.newImage("assets/icons/mk8.jpg"),
            canvas=lg.newCanvas(256,128),
            name="mariokart 8"
        }
    }
end

function gs:update()

end

function gs:draw(w,h)
    for k,v in ipairs(self.icons) do
        lg.setCanvas(v.canvas)
            local s=scaled(v.img,512)
            lg.draw(v.img,(v.canvas:getWidth()/2)+(math.cos(love.timer.getTime()/2)*16),v.canvas:getHeight()/2,0,s,s,v.img:getWidth()/2,v.img:getHeight()/2)
            lg.setColor(1,1,1,0.8)
            lg.print(v.name,2,v.canvas:getHeight()-font:getHeight()-2,0)
        lg.setCanvas()
    end
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

        lg.stencil(function()
            lg.rectangle("fill",64,64,256,128,8,8)
        end,"replace",1)
        lg.setStencilTest("greater", 0)
            lg.setColor(1,1,1,1)
            lg.draw(self.icons[1].canvas,64,64)
        lg.setStencilTest()
        lg.setColor(c)
        lg.setLineWidth(4)
        lg.rectangle("line",64,64,256,128,8,8)
        lg.setLineWidth(1)
    lg.translate(0,0)
    lg.pop()
end

return gs