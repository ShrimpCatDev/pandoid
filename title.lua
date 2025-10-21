local title={}

function title:enter()
    self.trans=lg.newCanvas(conf.gW,conf.gH)
    self.stat={prog=-0.2}
    self.wave=lg.newShader("wave.glsl")

    timer.tween(1,self.stat,{prog=1.5},"in-linear")

    self.transing=false
end

function title:update(dt)
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
    lg.setCanvas(self.trans)
            lg.setColor(0,0,0,0)
            lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setCanvas()

    lg.setColor(1,1,1,1)

    shove.beginDraw()
        lg.setColor(0.5,0.5,0.5)
        lg.rectangle("fill",0,0,conf.gW,conf.gH)
        lg.setColor(1,1,1)
        lg.print("this is a good title screen")
        lg.print("press z or space",0,5)

        lg.setShader(self.wave)
            lg.draw(self.trans)
        lg.setShader()
    shove.endDraw()
end

return title