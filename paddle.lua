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

    self.kind="player"

    self.vx=0
    self.vy=0

    self.spd=120

    world:add(self,self.x,self.y,self.w,self.h)
end

function paddle:update(dt)
    self.vx=0
    if input:down("left") then
        self.vx=-self.spd
    end
    if input:down("right") then
        self.vx=self.spd
    end
    local ax,ay,col,len=world:move(self,self.x+self.vx*dt,self.y+self.vy*dt,self.filter)
    self.x,self.y=ax,ay
end

function paddle:draw()
    lg.draw(self.img,self.x+self.w/2,self.y+self.h/2,self.r,1,1,self.w/2,self.h/2)
end

return paddle