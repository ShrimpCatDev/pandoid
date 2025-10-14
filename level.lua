local lvl={}

function lvl:init()

end

function lvl:enter()

end

function lvl:update(dt)

end

function lvl:draw()
    shove.beginDraw()
        love.graphics.rectangle("fill",0,0,8,8)
    shove.endDraw()
end

return lvl