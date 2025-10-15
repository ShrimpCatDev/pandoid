local lvl={}
bricks=require("bricks")

function lvl:init()
    
end

function lvl:enter()
    self.shader=lg.newShader("plasma.glsl")
    self.shader:send("time",love.timer.getTime())

    self.bg=lg.newCanvas(conf.gW,conf.gH)


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
    self.shader:send("time",love.timer.getTime())
end

function lvl:draw()
    lg.setCanvas(self.bg)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()
    shove.beginDraw()
        lg.setShader(self.shader)
            lg.draw(self.bg)
        lg.setShader()
        --love.graphics.rectangle("fill",0,0,8,8)
        bricks:draw()
    shove.endDraw()
end

return lvl