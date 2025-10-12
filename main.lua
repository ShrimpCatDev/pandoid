require("init")

function love.load()
    gs.switch(require("level"))
end

function love.update(dt)
    input:update()
end 

function love.draw()

end