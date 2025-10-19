local lvl={}
lvl.bricks=require("bricks")
lvl.ball=require("ball")
lvl.paddle=require("paddle")
lvl.levels={}
lvl.parts=require("lib.particles")

local maxLevels=2

for i=1,maxLevels do
    table.insert(lvl.levels,require("levels/lvl"..i))
end

lvl.level=1

function lvl:load()
    local l=self.levels[self.level]

    for y=1,#l do
        for x=1,#l[1] do
            if l[y][x]>0 then
                self.bricks:new((x-1)*self.bricks.w,(y-1)*self.bricks.h,l[y][x])
            end
        end
    end
end

function lvl:init()
    
end

function lvl:enter()
    self.plasmaShader=lg.newShader("plasma.glsl")
    self.plasmaShader:send("time",love.timer.getTime())

    self.bg=lg.newCanvas(conf.gW,conf.gH)

    world=bump.newWorld(16)

    self.ball:init(0,0)

    self.bricks:init()

    self.paddle:init()

    self:load()

    self.parts.clear()
end

function lvl:update(dt)

    if #self.bricks.b<1 then
        self.level=self.level+1
        if self.level>#self.levels then
            self.level=1
        end
        self:load()
        self.ball:place(80-4,64+4)
    end

    self.paddle:update(dt)
    self.ball:update(dt)
    self.bricks:update(dt)
    self.plasmaShader:send("time",love.timer.getTime())
    timer.update(dt)

    self.parts.update(dt)
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

        self.parts.draw()
    shove.endDraw()
end

return lvl