local title={}
title.img=lg.newImage("assets/title.png")

title.sound=love.audio.newSource("assets/titleMusic.mp3","stream")
title.sound:setLooping(true)

function title:enter()
    love.audio.stop()
    title.sound:play()
    self.trans=lg.newCanvas(conf.gW,conf.gH)
    self.stat={prog=-0.2,beat=1.818/2,scale=1}
    self.wave=lg.newShader("wave.glsl")

    timer.tween(1,self.stat,{prog=1.5},"in-linear",function()
        self.transing=false
    end)

    self.transing=true

    self.plasmaShader=lg.newShader("plasma.glsl")
    self.bg=lg.newCanvas(conf.gW,conf.gH)
    
end

function title:update(dt)

    self.plasmaShader:send("time",love.timer.getTime())

    self.stat.beat=self.stat.beat-dt

    if self.stat.beat<0 then
        self.stat.beat=1.818/2
        timer.tween(0.1,self.stat,{scale=1.2},"out-quad",function()
            timer.tween(0.2,self.stat,{scale=1},"in-quad")
        end)
    end
    timer.update(dt)
    self.wave:send("time",love.timer.getTime())
    self.wave:send("prog",self.stat.prog)

    if not self.transing then
        if input:pressed("action") then
            self.transing=true
            timer.tween(1,self.stat,{prog=-0.2},"in-linear",function() 
                gs.switch(state.lvl)
            end)
        end
    end
end

function title:draw()

    lg.setCanvas(self.bg)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()

    lg.setCanvas(self.trans)
            lg.setColor(0,0,0,0)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()

    lg.setColor(1,1,1,1)

    shove.beginDraw()

        lg.setShader(self.plasmaShader)
            lg.draw(self.bg)
        lg.setShader()

        lg.setColor(0,0,0,0.2)
        lg.rectangle("fill",0,0,conf.gW,conf.gH)
        lg.setColor(1,1,1,1)
        --lg.print("this is a good title screen")
        lg.draw(self.img,conf.gW/2,conf.gH/2 - 8,math.cos(love.timer.getTime())/4,self.stat.scale,self.stat.scale,self.img:getWidth()/2,self.img:getHeight()/2)
        local t="press z or space"
        lg.print(t,conf.gW/2-font:getWidth(t)/2,conf.gH/2+7)

        local t="a game by shrimpcat"
        lg.print(t,conf.gW/2-font:getWidth(t)/2,conf.gH-5)

        lg.setShader(self.wave)
            lg.draw(self.trans)
        lg.setShader()
    shove.endDraw()
end

return title