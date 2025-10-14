local bricks={}

function bricks:init()
    self.b={}
end

function bricks:update()

end

function bricks:draw()

end

function bricks:new(x,y,t)
    table.insert(self.b,{x=x,y=y,t=t})
end

return bricks