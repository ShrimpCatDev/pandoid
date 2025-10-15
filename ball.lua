local ball={}
ball.img=lg.newImage("assets/ball.png")

function ball.filter(self,obj)
    if obj.kind=="brick" then
        return "bounce"
    end
    return "slide"
end

function ball:init(x,y)
    self.move=false

    self.x=x
    self.y=y
    self.w=8
    self.h=8
    
    self.vx=0
    self.vy=0

    self.dx=1
    self.dy=1

    self.spd=80

    world:add(self,self.x,self.y,self.w,self.h)

    timer.after(2,function()
        self.move=true
    end)
end

function ball:update(dt)

    if self.move then
    
        self.vx=self.spd*dt*self.dx
        self.vy=self.spd*dt*self.dy

        local ax,ay,col,len=world:move(self,self.x+self.vx,self.y+self.vy,self.filter)

        for i=1,len do
            local c=col[i]
            if c.other.kind=="brick" or c.other.kind=="player" then
                if c.normal.x~=0 then self.dx=c.normal.x end
                if c.normal.y~=0 then self.dy=c.normal.y end
                col[i].other.dead=true
            end
        end

        if self.x<=0 then
            self.dx=1
        end
        if self.x>=conf.gW-self.w then
            self.dx=-1
        end
        if self.y<=0 then
            self.dy=1
        end
        if self.y>=conf.gH-self.h then
            self.dy=-1
        end

        self.x,self.y=ax,ay

        self.x=clamp(self.x,0,conf.gW)
        self.y=clamp(self.y,0,conf.gH)
    end
end

function ball:draw()
    lg.draw(self.img,self.x,self.y)
end

return ball