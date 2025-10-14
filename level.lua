local lvl={}
bricks=require("bricks")

function lvl:init()
    
end

function lvl:enter()
    world=bump.newWorld(16)
    bricks:init()

    for y=0,conf.gH/bricks.h-9 do
        for x=0,conf.gW/bricks.w do
            bricks:new(x*bricks.w,y*bricks.h,0)
        end
    end
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