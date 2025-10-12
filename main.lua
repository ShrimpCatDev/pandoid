require("init")

function love.load()
    state={
        lvl=require("level")
    }
    gs=require "lib.hump.gamestate"
    gs.registerEvents()
    gs.switch(state.lvl)
end

function love.update(dt)
    input:update()
end 

function love.draw()

end