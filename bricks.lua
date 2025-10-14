local bricks={}
bricks.img=lg.newImage("assets/brick.png")
bricks.w=16
bricks.h=8

function bricks:init()
    self.b={}
end

function bricks:update()

end

function bricks:draw()
    for k,b in ipairs(self.b) do
        lg.draw(self.img,b.x,b.y)
    end
end

function bricks:new(x,y,t)
    table.insert(self.b,{x=x,y=y,t=t,kind="brick"})
    local b=self.b[#self.b]
    world:add(b,b.x,b.y,self.w,self.h)
end

return bricks