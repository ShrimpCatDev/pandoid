local lvl={}
bricks=require("bricks")

function lvl:init()
    
end

function lvl:enter()
    bricks:init()
end

function lvl:update(dt)
    bricks:update(dt)
end

function lvl:draw()
    shove.beginDraw()
        --love.graphics.rectangle("fill",0,0,8,8)
        bricks:draw()
    shove.endDraw()
end

return lvl