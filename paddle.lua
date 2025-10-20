local paddle={}
paddle.img=lg.newImage("assets/paddle.png")

function paddle.filter()
    return "cross"
end

function paddle:init()
    self.x=conf.gW/2-self.img:getWidth()/2
    self.y=conf.gH-10

    self.r=0

    self.w=self.img:getWidth()
    self.h=self.img:getHeight()

    self.kind="player"

    self.vx=0
    self.vy=0

    self.oy=0

    self.spd=120

    self.bouncing=false

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

    self.x=clamp(self.x,0,conf.gW-self.w)
end

function paddle:draw()
    lg.draw(self.img,self.x+self.w/2,self.y+self.h/2+self.oy,self.r,1+self.oy/4,1-self.oy/5,self.w/2,self.h/2)
end

function paddle:bounce()
    if not self.bouncing then
        self.bouncing=true
        timer.tween(0.1,self,{oy=2},"out-quad")
        timer.after(0.1,function()
            timer.tween(0.45,self,{oy=0},"out-elastic",function()
                self.bouncing=false
            end)
            --[[timer.after(0.45,function()
                self.bouncing=true
            end)]]
        end)
    end
end

return paddle