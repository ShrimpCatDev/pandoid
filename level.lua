local lvl={}
lvl.bricks=require("bricks")
lvl.ball=require("ball")
lvl.paddle=require("paddle")
lvl.levels={}
parts=require("lib.particles")

lvl.bgm=love.audio.newSource("assets/bgm.ogg","stream")
lvl.bgm:setLooping(true)
lvl.bgm:setVolume(150)

shove.createLayer("game")

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

function changeScore(score)
    lvl.score=lvl.score+score
    if lvl.stat.sm then
        lvl.stat.sm=false
        timer.tween(0.1,lvl.stat,{sy=-2},"out-cubic",function()
            timer.tween(0.1,lvl.stat,{sy=0},"in-cubic",function()
                lvl.stat.sm=true
            end)
        end)
    end
end

function lvl:enter()

    love.audio.stop()
    self.bgm:play()

    self.score=0
    self.stat={sy=0,sm=true,prog=-0.2}

    timer.tween(1,self.stat,{prog=1.5},"in-linear")

    self.timer=0

    self.pause=false

    self.plasmaShader=lg.newShader("plasma.glsl")
    self.plasmaShader:send("time",love.timer.getTime())

    self.wave=lg.newShader("wave.glsl")
    --self.wave:send("time",love.timer.getTime())

    self.bg=lg.newCanvas(conf.gW,conf.gH)

    world=bump.newWorld(16)

    self.ball:init(0,0)

    self.bricks:init()

    self.paddle:init()

    self:load()

    parts.clear()

    self.trans=lg.newCanvas(conf.gW,conf.gH)
end

function lvl:update(dt)
    if not self.paused then
        self.timer=self.timer+dt
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
        self.plasmaShader:send("time",self.timer)
        self.wave:send("time",love.timer.getTime())

        self.wave:send("prog",self.stat.prog)
        timer.update(dt)

        parts.update(dt)
    end

    if input:pressed("pause") then
        if self.paused==true then
            self.paused=false
        else
            self.paused=true
        end
    end
end

function lvl:draw()
    lg.setCanvas(self.bg)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()

    lg.setCanvas(self.trans)
            lg.setColor(0,0,0,0)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()

    lg.setColor(1,1,1,1)

    shove.beginDraw()
        shove.beginLayer("game")
        lg.setShader(self.plasmaShader)
            lg.draw(self.bg)
        lg.setShader()

        
        --love.graphics.rectangle("fill",0,0,8,8)
        self.bricks:draw(self.timer)
        self.ball:draw()
        self.paddle:draw()

        parts.draw()

        lg.setColor(0,0,0,0.5)
        lg.rectangle("fill",0,0,conf.gW,6)
        lg.setColor(1,1,1,1)
        lg.print("score: "..self.score,1,1+self.stat.sy)

        local str="balls: "..self.ball.lives
        lg.print(str,conf.gW-1-font:getWidth(str),1)

        lg.setShader(self.wave)
            lg.draw(self.trans)
        lg.setShader()

        shove.endLayer()
    shove.endDraw()
end

return lvl