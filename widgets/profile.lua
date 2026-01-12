local pro={}

function pro:init()
    self.x=64
    self.y=48
    self.pfp=lg.newImage("assets/profile.png")
    self.ofs=0

    self.stencil=function()
        
    end
end

function pro:update()

end

function pro:draw(w,h)
    lg.push()
    lg.translate(self.x,self.y)
        local txt=os.date("%H:%M")
        self.ofs=font:getWidth(txt)
        lg.setColor(color(currentTheme.ui))
        lg.rectangle("fill",0,0,self.ofs+32,font:getHeight()+4,16,16)
        lg.setColor(color(currentTheme.text))
        lg.print(txt,16,2)
        lg.setColor(1,1,1,1)
        local s=scaled(self.pfp,52)
        lg.draw(self.pfp,self.ofs+28,-8,0,s,s)
    lg.translate(0,0)
    lg.pop()
end

return pro