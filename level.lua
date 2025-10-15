local lvl={}
lvl.bricks=require("bricks")
lvl.ball=require("ball")
lvl.paddle=require("paddle")

function lvl:init()
    
end

function lvl:enter()
    
    self.plasmaShader=lg.newShader("plasma.glsl")
    self.plasmaShader:send("time",love.timer.getTime())

    --self.waveShader=lg.newShader("wave.glsl")

    self.bg=lg.newCanvas(conf.gW,conf.gH)

    world=bump.newWorld(16)

    self.ball:init(0,0)

    self.bricks:init()

    self.paddle:init()

    for y=1,conf.gH/self.bricks.h-9 do
        for x=1,conf.gW/self.bricks.w-2 do
            self.bricks:new(x*self.bricks.w,y*self.bricks.h,0)
        end
    end
end

function lvl:update(dt)

    if #self.bricks.b<1 then
        for y=1,conf.gH/self.bricks.h-9 do
            for x=1,conf.gW/self.bricks.w-2 do
                self.bricks:new(x*self.bricks.w,y*self.bricks.h,0)
            end
        end
        self.ball:place(80-4,64+4)
    end

    self.paddle:update(dt)
    self.ball:update(dt)
    self.bricks:update(dt)
    self.plasmaShader:send("time",love.timer.getTime())
    timer.update(dt)

    
end

function lvl:draw()
    lg.setCanvas(self.bg)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()
    shove.beginDraw()
        lg.setShader(self.plasmaShader)
            lg.draw(self.bg)
        lg.setShader()
        --love.graphics.rectangle("fill",0,0,8,8)
        self.bricks:draw()
        self.ball:draw()
        self.paddle:draw()
    shove.endDraw()
end

return lvl