local ball={}
ball.img=lg.newImage("assets/ball.png")
ball.bounceSound=love.audio.newSource("assets/edgeHit.ogg","static")

function ball.filter(self,obj)
    if obj.kind=="player" then
        if self.y+ball.h/2<=obj.y then
            return "slide"
        else
            return nil
        end
    end
    return "slide"
end

function ball:init(x,y)
    ball.lives=5

    self.move=true

    self.x=x
    self.y=y
    self.w=8
    self.h=8
    
    self.vx=0
    self.vy=0

    self.dx=1
    self.dy=1

    self.spd=80

    self.mode="place" --place,move

    world:add(self,self.x,self.y,self.w,self.h)
end

function ball:place(x,y)
    self.mode="place"
end

function ball:change(x,y)
    self.x=x
    self.y=y
    world:update(self,x,y)
end

function ball:update(dt)
    if self.mode=="move" then
        if self.move then
    
            self.vx=self.spd*dt*self.dx
            self.vy=self.spd*dt*self.dy

            local ax,ay,col,len=world:move(self,self.x+self.vx,self.y+self.vy,self.filter)

            for i=1,len do
                local c=col[i]
                if c.other.kind=="brick" or c.other.kind=="player" then
                    if c.normal.x~=0 then self.dx=c.normal.x end
                    if c.normal.y~=0 then self.dy=c.normal.y end

                    if c.other.kind=="brick" then
                        col[i].other.hp = col[i].other.hp-1
                        col[i].other.cd=0
                        shakeScreen()
                    end
                end
                if c.other.kind=="player" then
                    c.other:bounce()
                end
            end

            if self.x<=0 then
                ball.bounceSound:play()
                self.dx=1
            end
            if self.x>=conf.gW-self.w then
                ball.bounceSound:play()
                self.dx=-1
            end
            if self.y<=0 then
                ball.bounceSound:play()
                self.dy=1
            end
            --[[if self.y>=conf.gH-self.h then
                self.dy=-1
            end]]

            self.x,self.y=ax,ay

            self.x=clamp(self.x,0,conf.gW-self.w)
            self.y=clamp(self.y,0,math.huge)

            if self.y>conf.gH then
                self.lives=self.lives-1
                self:place(80-4,64+4)
            end
        end
    else
        local p=state.lvl.paddle
        ball:change(p.x+(p.w/2)-4,p.y-10)

        if input:pressed("left") then
            self.dx=-1
        end
        if input:pressed("right") then
            self.dx=1
        end

        if input:pressed("action") then
            self.dy=-1
            self.mode="move"
        end
    end
end

function ball:draw()
    lg.draw(self.img,self.x,self.y)
end

return ball