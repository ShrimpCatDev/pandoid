local paddle={}
paddle.img=lg.newImage("assets/paddle.png")

function paddle.filter()
    return "cross"
end

function paddle:init()
    self.x=0
    self.y=conf.gH-10

    self.r=0

    self.w=self.img:getWidth()
    self.h=self.img:getHeight()
end

function paddle:update(dt)

end

function paddle:draw()
    lg.draw(self.img,self.x+self.w/2,self.y+self.h/2,self.r,1,1,self.w/2,self.h/2)
end

return paddle