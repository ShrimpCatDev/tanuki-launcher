local pro={}

function pro:init()
    self.x=64
    self.y=48
    self.pfp=lg.newImage("assets/profile.png")
    self.ofs=0
end

function pro:update()

end

function pro:draw(w,h)
    lg.push()
    lg.translate(self.x,self.y)
        local pfpScale=48

        local txt=os.date("%H:%M")
        local x=self.ofs+28
        local y=-8
        local radius=pfpScale/2

        self.ofs=font:getWidth(txt)
        lg.setColor(color(currentTheme.ui))
        lg.rectangle("fill",0,0,self.ofs+32,font:getHeight()+4,16,16)
        lg.circle("fill", x+radius, y+radius,radius+4)

        lg.setColor(color(currentTheme.text))
        lg.print(txt,16,2)
        lg.setColor(1,1,1,1)

        local s=scaled(self.pfp,pfpScale)
        lg.stencil(function()
            lg.circle("fill", x+radius, y+radius,radius)
        end,"replace",1)

        lg.setStencilTest("greater", 0)
            lg.draw(self.pfp,x,y,0,s,s)
        lg.setStencilTest()
        
    lg.translate(0,0)
    lg.pop()
end

return pro