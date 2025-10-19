local title={}

function title:enter()

end

function title:update()

end

function title:draw()
    shove.beginDraw()
        lg.print("press z or space")
    shove.endDraw()
end

return title