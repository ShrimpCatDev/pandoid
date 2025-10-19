local bricks={}
bricks.img=lg.newImage("assets/brick.png")
bricks.w=16
bricks.h=8

bricks.data={
    {img=lg.newImage("assets/brick.png"),hp=1,score=10},
    {img=lg.newImage("assets/brickBlue.png"),hp=2,score=20},
    {img=lg.newImage("assets/brickPink.png"),hp=3,score=30},
    {img=lg.newImage("assets/brickWhite.png"),hp=1,score=10}
}

function bricks:init()
    self.b={}
    self.p={}
end

function bricks:particle(x1,y1)
    for i=0,11 do
        local spd=16
        parts.new(x1+math.random(-self.w/2,self.w/2),y1,math.random(-spd,spd),math.random(-spd*2,spd/2),0,80,math.random(5,7)*0.1,
        function(x,y,lt)
            lg.setColor(1,1,1,lt)
            lg.circle("fill",x,y,lt*8)
        end,

        function()
            
        end)
    end
end

function bricks:update(dt)
    local rmv={}
    for k,b in ipairs(self.b) do
        local bcd=b.cd

        if b.cd==0 and not b.dead then
            changeScore(self.data[b.t].score)
            timer.tween(0.1,b,{dy=-2},"out-cubic",function()
                timer.tween(0.1,b,{dy=0},"out-cubic")
            end)
            bricks:particle(b.x+self.w/2,b.y+self.h/2)
        end

        b.cd=b.cd+dt
        if b.hp<=0 then
            b.dead=true
        end
        if b.dead then
            table.insert(rmv,k)
            world:remove(b)
            table.insert(self.p,{x=b.x,y=b.y,t=b.t,r=b.r,dead=false,s=1})
        end
    end

    for i=#rmv,1,-1 do
        table.remove(self.b,rmv[i])
    end

    local rmv={}
    for k,b in ipairs(self.p) do
        b.y=b.y+40*dt
        b.r=b.r+20*dt
        b.s=b.s-4*dt

        if b.s<=0 then
            b.dead=true
        end

        if b.dead then
            table.insert(rmv,k)
        end
    end
    for i=#rmv,1,-1 do
        table.remove(self.p,rmv[i])
    end
end

function bricks:draw(timer)
    for k,b in ipairs(self.b) do
        lg.draw(self.data[b.t].img,b.x+self.w/2,b.y+self.h/2+b.dy,b.r+math.cos(timer+k*0.2)*0.1,1,1,self.w/2,self.h/2)
    end

    for k,b in ipairs(self.p) do
        lg.draw(self.data[b.t].img,b.x+self.w/2,b.y+self.h/2,b.r+math.cos(timer+k*0.2)*0.1,b.s,b.s,self.w/2,self.h/2)
    end
end

function bricks:new(x,y,t)
    table.insert(self.b,{x=x,y=-8,t=t,kind="brick",r=math.random(-2,2),dead=false,hp=self.data[t].hp,cd=0.01,dy=0})
    local b=self.b[#self.b]
    world:add(b,x,y,self.w,self.h)
    timer.tween(math.random(10,18)/10,b,{y=y},"out-elastic")
    timer.tween(math.random(10,18)/10,b,{r=0},"out-elastic")
end

return bricks